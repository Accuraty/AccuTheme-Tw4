[CmdletBinding()]
param(
    # File to upload (absolute or relative to repo root)
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Path,

    # Path to an sftp.json-like config file. Defaults to your local VS Code SFTP config.
    [Parameter(Mandatory = $false)]
    [string]$SftpConfigRel = ".vscode/sftp.json",

    # Use env vars instead of config values when present.
    # ACCU_FTP_HOST, ACCU_FTP_USER, ACCU_FTP_PASS
    [switch]$PreferEnv,

    # Optional: pin TLS certificate fingerprint (recommended for real security)
    # Example: "xx:xx:..." (WinSCP format)
    [string]$TlsFingerprint,

    # Allow uploading files outside the sftp.json context (./dnn). Off by default.
    [switch]$AllowOutsideContext,

    # Ignore patterns from sftp.json. Use -Force to bypass ignore checks.
    [switch]$Force,

    # Print what would happen, but do not connect/upload.
    [switch]$DryRun,

    # Override FTP mode. If not specified, defaults to Passive.
    # The script will retry once using the opposite mode if the first attempt fails.
    [ValidateSet('Passive', 'Active')]
    [string]$FtpMode,

    # Verify the remote file exists after upload (off by default).
    [switch]$Verify
)

# WinSCP .NET assembly shipped in the Automation package targets .NET Framework.
# When run from PowerShell Core (pwsh), it can fail to load due to missing APIs.
# Reinvoke this script under Windows PowerShell 5.1 for compatibility.
if ($PSVersionTable.PSEdition -eq 'Core') {
    $windowsPowerShell = Join-Path $env:WINDIR 'System32\WindowsPowerShell\v1.0\powershell.exe'
    if (-not (Test-Path -LiteralPath $windowsPowerShell)) {
        throw "WinSCPnet.dll requires Windows PowerShell (Full .NET Framework). Could not find: $windowsPowerShell"
    }

    # IMPORTANT: When this script is run with parameters, PowerShell binds them to
    # the param() block, so they are NOT available in $args. Forward bound
    # parameters explicitly to avoid interactive prompts in the reinvoked process.
    $forwardArgs = @()

    if ($PSBoundParameters.ContainsKey('Path')) { $forwardArgs += $PSBoundParameters['Path'] }
    if ($PSBoundParameters.ContainsKey('SftpConfigRel')) { $forwardArgs += @('-SftpConfigRel', $PSBoundParameters['SftpConfigRel']) }
    if ($PSBoundParameters.ContainsKey('TlsFingerprint')) { $forwardArgs += @('-TlsFingerprint', $PSBoundParameters['TlsFingerprint']) }
    if ($PSBoundParameters.ContainsKey('FtpMode')) { $forwardArgs += @('-FtpMode', $PSBoundParameters['FtpMode']) }

    if ($PreferEnv.IsPresent) { $forwardArgs += '-PreferEnv' }
    if ($AllowOutsideContext.IsPresent) { $forwardArgs += '-AllowOutsideContext' }
    if ($Force.IsPresent) { $forwardArgs += '-Force' }
    if ($DryRun.IsPresent) { $forwardArgs += '-DryRun' }
    if ($Verify.IsPresent) { $forwardArgs += '-Verify' }

    $scriptPath = $MyInvocation.MyCommand.Path
    & $windowsPowerShell -NoProfile -ExecutionPolicy Bypass -File $scriptPath @forwardArgs
    exit $LASTEXITCODE
}

$ErrorActionPreference = 'Stop'

function Get-ProjectRoot {
    if (-not $PSScriptRoot) {
        throw "PSScriptRoot is not available. Run this as a script file, not by copy/pasting into the terminal."
    }
    return (Split-Path -Parent $PSScriptRoot)
}

function Get-RelativePath {
    param(
        [Parameter(Mandatory = $true)][string]$BasePath,
        [Parameter(Mandatory = $true)][string]$TargetPath
    )

    $baseFull = [System.IO.Path]::GetFullPath($BasePath)
    if (-not $baseFull.EndsWith('\')) { $baseFull += '\' }
    $targetFull = [System.IO.Path]::GetFullPath($TargetPath)

    $baseUri = New-Object System.Uri($baseFull)
    $targetUri = New-Object System.Uri($targetFull)

    $relUri = $baseUri.MakeRelativeUri($targetUri)
    $rel = [System.Uri]::UnescapeDataString($relUri.ToString())

    return ($rel -replace '/', '\')
}

function Normalize-Slash([string]$p) {
    return ($p -replace '\\', '/').Trim()
}

function Convert-GlobToRegex([string]$glob) {
    # Supports: *, ?, ** and both \ and / separators.
    $g = Normalize-Slash $glob

    # Escape regex meta
    $g = [Regex]::Escape($g)

    # Unescape our glob tokens and convert
    # **/  or **\  -> match any path segments
    $g = $g -replace '\\Q\*\*\\E', '§§DOUBLESTAR§§'
    $g = $g -replace '\\Q\*\\E', '§§STAR§§'
    $g = $g -replace '\\Q\?\\E', '§§QMARK§§'

    # Convert tokens
    $g = $g -replace '§§DOUBLESTAR§§', '.*'
    $g = $g -replace '§§STAR§§', '[^/]*'
    $g = $g -replace '§§QMARK§§', '[^/]'

    # Anchor
    return "^$g$"
}

function Is-Ignored([string]$relativePath, [string[]]$ignoreGlobs) {
    $rel = Normalize-Slash $relativePath

    foreach ($glob in $ignoreGlobs) {
        if (-not $glob) { continue }
        $g = Normalize-Slash $glob

        # Normalize a couple of common cases from sftp.json
        # If glob ends with '/', treat it as "anything under this dir"
        if ($g.EndsWith('/')) {
            $g = $g + '**'
        }

        $re = Convert-GlobToRegex $g
        if ($rel -match $re) {
            return $true
        }
    }

    return $false
}

$projectRoot = Get-ProjectRoot

# Resolve target file
$inputPath = $Path
if (-not [System.IO.Path]::IsPathRooted($inputPath)) {
    $inputPath = Join-Path $projectRoot $inputPath
}
$inputPath = (Resolve-Path -LiteralPath $inputPath).ProviderPath
$inputPath = [System.IO.Path]::GetFullPath($inputPath)

# Load config
$sftpConfigPath = $SftpConfigRel
if (-not [System.IO.Path]::IsPathRooted($sftpConfigPath)) {
    $sftpConfigPath = Join-Path $projectRoot $sftpConfigPath
}

if (-not (Test-Path -LiteralPath $sftpConfigPath)) {
    throw "SFTP config not found at: $sftpConfigPath"
}

$config = Get-Content -LiteralPath $sftpConfigPath -Raw | ConvertFrom-Json

# Pull connection settings (optionally from env)
$ftpHost = $config.host
$user = $config.username
$pass = $config.password

if ($PreferEnv) {
    if ($env:ACCU_FTP_HOST) { $ftpHost = $env:ACCU_FTP_HOST }
    if ($env:ACCU_FTP_USER) { $user = $env:ACCU_FTP_USER }
    if ($env:ACCU_FTP_PASS) { $pass = $env:ACCU_FTP_PASS }
}

if (-not $ftpHost) { throw "Missing host (config.host or ACCU_FTP_HOST)." }
if (-not $user) { throw "Missing username (config.username or ACCU_FTP_USER)." }
if (-not $pass) { throw "Missing password (config.password or ACCU_FTP_PASS)." }

# Map local -> remote
$contextRel = $config.context
if (-not $contextRel) { $contextRel = './dnn' }

$localRoot = Join-Path $projectRoot $contextRel
$localRoot = (Resolve-Path -LiteralPath $localRoot).ProviderPath
$localRoot = [System.IO.Path]::GetFullPath($localRoot)

if (-not $AllowOutsideContext) {
    $relCheck = Get-RelativePath -BasePath $localRoot -TargetPath $inputPath
    if ($relCheck -eq '..' -or $relCheck.StartsWith('..\\', [StringComparison]::OrdinalIgnoreCase) -or $relCheck.StartsWith('../', [StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing to upload outside context '$contextRel' ($localRoot). Use -AllowOutsideContext to override."
    }
}

# Calculate relative path from context root
if ($AllowOutsideContext) {
    $relativePath = Split-Path -Path $inputPath -Leaf
} else {
    $relativePath = Get-RelativePath -BasePath $localRoot -TargetPath $inputPath
}

# Ignore checks based on sftp.json patterns (only when file is within context)
if (-not $Force -and -not $AllowOutsideContext) {
    $ignore = @()
    if ($config.ignore) {
        $ignore = @($config.ignore)
    }

    if (Is-Ignored $relativePath $ignore) {
        throw "Refusing to upload ignored path: $relativePath. Use -Force to override."
    }
}

$remoteRoot = $config.remotePath
if (-not $remoteRoot) { $remoteRoot = '/' }

$remotePath = (Normalize-Slash ($remoteRoot.TrimEnd('/') + '/' + (Normalize-Slash $relativePath))).Trim()
if (-not $remotePath.StartsWith('/')) {
    $remotePath = '/' + $remotePath
}

Write-Host "Upload mapping:" -ForegroundColor Cyan
Write-Host "  Local:  $inputPath"
Write-Host "  Rel:    $relativePath"
Write-Host "  Remote: $remotePath"

if ($DryRun) {
    Write-Host "DryRun: not uploading." -ForegroundColor Yellow
    return
}

# Ensure WinSCP assembly exists
$winscpRoot = Join-Path $projectRoot 'tools/winscp'
$currentFile = Join-Path $winscpRoot '.current-version.txt'

function Try-ParseVersion([string]$s) {
    try { return [version]$s } catch { return $null }
}

function Resolve-WinScpInstallDir([string]$root) {
    if (-not (Test-Path -LiteralPath $root)) { return $null }

    if (Test-Path -LiteralPath (Join-Path $root '.current-version.txt')) {
        try {
            $folder = (Get-Content -LiteralPath (Join-Path $root '.current-version.txt') -Raw).Trim()
            if ($folder) {
                $candidate = Join-Path $root $folder
                if (Test-Path -LiteralPath (Join-Path $candidate 'WinSCPnet.dll')) {
                    return $candidate
                }
            }
        } catch { }
    }

    # Legacy flat install
    if (Test-Path -LiteralPath (Join-Path $root 'WinSCPnet.dll')) {
        return $root
    }

    # Pick highest versioned subfolder
    $dirs = Get-ChildItem -LiteralPath $root -Directory -ErrorAction SilentlyContinue
    $best = $null
    $bestVer = $null
    foreach ($d in $dirs) {
        $ver = Try-ParseVersion $d.Name
        if ($null -eq $ver) { continue }
        if (-not (Test-Path -LiteralPath (Join-Path $d.FullName 'WinSCPnet.dll'))) { continue }
        if ($null -eq $bestVer -or $ver -gt $bestVer) {
            $bestVer = $ver
            $best = $d.FullName
        }
    }

    return $best
}

$winscpDir = Resolve-WinScpInstallDir $winscpRoot
if (-not $winscpDir) {
    throw "WinSCP not installed locally. Run 'npm run winscp:ensure' first. Expected an install under: $winscpRoot"
}

$winscpNet = Join-Path $winscpDir 'WinSCPnet.dll'
$winscpExe = Join-Path $winscpDir 'WinSCP.exe'

if (-not (Test-Path -LiteralPath $winscpExe)) {
    throw "WinSCP.exe not found in the selected WinSCP install: $winscpDir. Re-run 'npm run winscp:ensure'."
}

Add-Type -Path $winscpNet

# Build session options from sftp.json
$sessionOptions = New-Object WinSCP.SessionOptions
$sessionOptions.Protocol = [WinSCP.Protocol]::Ftp
$sessionOptions.HostName = $ftpHost
$sessionOptions.UserName = $user
$sessionOptions.Password = $pass

if ($config.port) {
    $sessionOptions.PortNumber = [int]$config.port
}

# FTPS explicit if secure=true
if ($config.secure -eq $true) {
    $sessionOptions.FtpSecure = [WinSCP.FtpSecure]::Explicit

    if ($TlsFingerprint) {
        $sessionOptions.TlsHostCertificateFingerprint = $TlsFingerprint
    } else {
        # Mirrors sftp.json secureOptions.rejectUnauthorized=false behavior
        if ($config.secureOptions -and $config.secureOptions.rejectUnauthorized -eq $false) {
            $sessionOptions.GiveUpSecurityAndAcceptAnyTlsHostCertificate = $true
        }
    }
}

# Sets FTP data connection mode
function Set-FtpMode([WinSCP.SessionOptions]$opts, [string]$mode) {
    if ($mode -eq 'Passive') {
        $opts.FtpMode = [WinSCP.FtpMode]::Passive
    } elseif ($mode -eq 'Active') {
        $opts.FtpMode = [WinSCP.FtpMode]::Active
    }
}

$primaryMode = if ($FtpMode) { $FtpMode } else { 'Passive' }

$modesToTry = @($primaryMode)

if ($primaryMode -eq 'Active') {
    # Common FTPS failure mode behind NAT/firewalls; retry once in Passive
    $modesToTry += 'Passive'
} else {
    # Some servers/network setups require Active mode
    $modesToTry += 'Active'
}

# Open session and upload
$transferOptions = New-Object WinSCP.TransferOptions
$transferOptions.TransferMode = [WinSCP.TransferMode]::Binary

$remoteDir = '/'
$lastSlash = $remotePath.LastIndexOf('/')
if ($lastSlash -gt 0) {
    $remoteDir = $remotePath.Substring(0, $lastSlash)
}
$remoteDir = Normalize-Slash $remoteDir
if (-not $remoteDir.StartsWith('/')) { $remoteDir = '/' + $remoteDir }

$logDir = Join-Path $projectRoot 'logs'
if (-not (Test-Path -LiteralPath $logDir)) { New-Item -ItemType Directory -Path $logDir -Force | Out-Null }

$lastError = $null
foreach ($mode in $modesToTry) {
    $session = New-Object WinSCP.Session
    $session.ExecutablePath = $winscpExe
    $session.SessionLogPath = Join-Path $logDir 'winscp-session.log'

    try {
        Set-FtpMode -opts $sessionOptions -mode $mode

        Write-Host "Connecting to $ftpHost (FTP mode: $mode)..." -ForegroundColor Cyan
        $session.Open($sessionOptions)

        if ($remoteDir -and $remoteDir -ne '/') {
            Write-Host "Ensuring remote directory: $remoteDir" -ForegroundColor Cyan
            $null = $session.CreateDirectory($remoteDir)
        }

        Write-Host "Uploading..." -ForegroundColor Cyan
        $result = $session.PutFiles($inputPath, $remotePath, $false, $transferOptions)
        $result.Check()

        if ($Verify) {
            Write-Host "Verifying remote file exists..." -ForegroundColor Cyan
            if (-not $session.FileExists($remotePath)) {
                throw "Upload completed but remote file was not found: $remotePath"
            }

            $info = $session.GetFileInfo($remotePath)
            $mtimeUtc = $null
            if ($info -and $info.LastWriteTime -ne [datetime]::MinValue) {
                $mtimeUtc = $info.LastWriteTime.ToUniversalTime().ToString('u')
            }

            if ($mtimeUtc) {
                Write-Host ("Remote verified: {0} bytes; mtime (UTC): {1}" -f $info.Length, $mtimeUtc) -ForegroundColor Green
            } else {
                Write-Host ("Remote verified: {0} bytes" -f $info.Length) -ForegroundColor Green
            }
        }

        Write-Host "Uploaded successfully." -ForegroundColor Green
        return
    }
    catch {
        $lastError = $_
        $msg = $_.Exception.Message

        if ($mode -eq 'Active' -and $msg -match 'active mode|425') {
            Write-Warning "Active mode upload failed; retrying in Passive mode. Details: $msg"
            continue
        }

        throw
    }
    finally {
        $session.Dispose()
    }
}

if ($lastError) {
    throw $lastError
}
