[CmdletBinding(SupportsShouldProcess = $true)]
param(
    # WinSCP version to install.
    # Used to build the landing page URL on winscp.net (which contains the real CDN link).
    [Parameter(Mandatory = $false)]
    [string]$Version = "6.5.5",

    # URL to the WinSCP Automation download page/zip.
    # If you pass the winscp.net landing URL, the script will extract the real CDN link automatically.
    # Examples:
    # - https://winscp.net/download/WinSCP-<version>-Automation.zip
    # - https://cdn.winscp.net/files/WinSCP-<version>-Automation.zip?secure=...,...
    [Parameter(Mandatory = $false)]
    [string]$Uri,

    # Folder to install WinSCP into (gitignored in this repo)
    [Parameter(Mandatory = $false)]
    [string]$InstallDirRel = "tools/winscp",

    # Folder to store downloaded zips into (gitignored in this repo)
    [Parameter(Mandatory = $false)]
    [string]$DownloadDirRel = "tools/_downloads",

    # Overwrite existing install folder
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

function Get-DownloadUriFromLandingHtml {
    param(
        [Parameter(Mandatory = $true)][string]$Html,
        [Parameter(Mandatory = $true)][string]$Version
    )

    $escapedVersion = [Regex]::Escape($Version)

    # Prefer the CDN link, as it should be the actual file (includes expiring secure token)
    $cdnPattern = 'https://cdn\.winscp\.net/files/WinSCP-' + $escapedVersion + '-Automation\.zip\?secure=[^"\s]+'
    $m = [Regex]::Match($Html, $cdnPattern, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    if ($m.Success) {
        return $m.Value
    }

    # Fallback: SourceForge "Alternative download" link
    $sfPattern = 'https://sourceforge\.net/projects/winscp/files/WinSCP/' + $escapedVersion + '/WinSCP-' + $escapedVersion + '-Automation\.zip/download'
    $m2 = [Regex]::Match($Html, $sfPattern, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    if ($m2.Success) {
        return $m2.Value
    }

    return $null
}

function Test-IsZipFile {
    param([Parameter(Mandatory = $true)][string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) { return $false }
    try {
        $bytes = [System.IO.File]::ReadAllBytes($Path)
        if ($bytes.Length -lt 2) { return $false }
        # ZIP magic: 0x50 0x4B => "PK"
        return ($bytes[0] -eq 0x50 -and $bytes[1] -eq 0x4B)
    } catch {
        return $false
    }
}

function Invoke-DownloadFile {
    param(
        [Parameter(Mandatory = $true)][string]$Uri,
        [Parameter(Mandatory = $true)][string]$OutFile
    )

    Invoke-WebRequest -Uri $Uri -OutFile $OutFile -MaximumRedirection 10 -UserAgent 'Mozilla/5.0' -ErrorAction Stop
}

function Get-ProjectRoot {
    if (-not $PSScriptRoot) {
        throw "PSScriptRoot is not available. Run this as a script file, not by copy/pasting into the terminal."
    }
    return (Split-Path -Parent $PSScriptRoot)
}

function Ensure-Directory([string]$path) {
    if (-not (Test-Path -LiteralPath $path)) {
        New-Item -ItemType Directory -Path $path -Force | Out-Null
    }
}

$projectRoot = Get-ProjectRoot
$installRoot = Join-Path $projectRoot $InstallDirRel
$downloadDir = Join-Path $projectRoot $DownloadDirRel

$currentVersionFile = Join-Path $installRoot '.current-version.txt'

$installFolderName = $Version
if (Test-Path -LiteralPath $currentVersionFile) {
    try {
        $installFolderName = (Get-Content -LiteralPath $currentVersionFile -Raw).Trim()
        if (-not $installFolderName) { $installFolderName = $Version }
    }
    catch {
        $installFolderName = $Version
    }
}

$installDir = Join-Path $installRoot $installFolderName

$winscpExe = Join-Path $installDir 'WinSCP.exe'
$winscpNet = Join-Path $installDir 'WinSCPnet.dll'

$alreadyInstalled = (Test-Path -LiteralPath $winscpNet) -and (Test-Path -LiteralPath $winscpExe)

if ($alreadyInstalled -and -not $Force) {
    Write-Host "WinSCP is already present." -ForegroundColor Green
    Write-Host "  $winscpExe"
    Write-Host "  $winscpNet"
    return
}

if (-not $Uri) {
    # This URL is a landing page that contains the real (tokenized) CDN link.
    $Uri = "https://winscp.net/download/WinSCP-$Version-Automation.zip/download"
}

Ensure-Directory $downloadDir

$zipName = Split-Path -Path $Uri -Leaf
if (-not $zipName.EndsWith('.zip', [StringComparison]::OrdinalIgnoreCase)) {
    $zipName = "WinSCP-$Version-Automation.zip"
}
$zipPath = Join-Path $downloadDir $zipName

$didInstall = $false

if ($PSCmdlet.ShouldProcess($Uri, "Download WinSCP Automation ZIP")) {
    Write-Host "Downloading WinSCP Automation ZIP..." -ForegroundColor Cyan
    Write-Host "  Requested: $Uri"
    Write-Host "  To:        $zipPath"

    $downloadUri = $Uri

    # If the user passed the winscp.net landing URL, it returns HTML.
    # Fetch the HTML and extract the real CDN URL containing the expiring secure token.
    try {
        $u = [Uri]$Uri
        if ($u.Host -ieq 'winscp.net') {
            Write-Host "Resolving WinSCP CDN download link..." -ForegroundColor Cyan
            $resp = Invoke-WebRequest -Uri $Uri -MaximumRedirection 10 -UserAgent 'Mozilla/5.0' -ErrorAction Stop
            $resolved = Get-DownloadUriFromLandingHtml -Html $resp.Content -Version $Version
            if (-not $resolved) {
                throw "Could not locate the CDN/alternative download link on the WinSCP landing page."
            }
            $downloadUri = $resolved
            Write-Host "  Resolved:  $downloadUri" -ForegroundColor DarkCyan
        }
    }
    catch {
        throw "Failed to resolve WinSCP download URL: $($_.Exception.Message)"
    }

    # Download the actual zip
    Invoke-DownloadFile -Uri $downloadUri -OutFile $zipPath

    if (-not (Test-IsZipFile -Path $zipPath)) {
        throw "Downloaded file is not a ZIP. The URL may have returned HTML or an error page. Try re-running, or specify a direct CDN URL from the WinSCP download page. File: $zipPath"
    }
}

if ($PSCmdlet.ShouldProcess($installDir, "Install WinSCP Automation")) {
    Ensure-Directory $installRoot

    # Prefer installing into a versioned folder. If the target folder exists and files are locked,
    # fall back to a unique folder and mark it as current.
    $desiredFolderName = $Version
    $desiredInstallDir = Join-Path $installRoot $desiredFolderName
    if (Test-Path -LiteralPath $desiredInstallDir) {
        if (-not $Force) {
            throw "Install directory already exists: $desiredInstallDir. Re-run with -Force to overwrite."
        }

        try {
            Remove-Item -LiteralPath $desiredInstallDir -Recurse -Force -ErrorAction Stop
        }
        catch {
            $desiredFolderName = "$Version-" + [Guid]::NewGuid().ToString('N').Substring(0, 8)
            $desiredInstallDir = Join-Path $installRoot $desiredFolderName
            Write-Warning "Could not remove existing '$Version' install folder (likely locked). Installing into '$desiredFolderName' instead."
        }
    }

    $installFolderName = $desiredFolderName
    $installDir = $desiredInstallDir
    $winscpExe = Join-Path $installDir 'WinSCP.exe'
    $winscpNet = Join-Path $installDir 'WinSCPnet.dll'

    Ensure-Directory $installDir

    $extractDir = Join-Path $downloadDir ("winscp-extract-" + [Guid]::NewGuid().ToString('N'))
    try {
        Ensure-Directory $extractDir
        Write-Host "Extracting..." -ForegroundColor Cyan
        Expand-Archive -Path $zipPath -DestinationPath $extractDir -Force

        # The Automation ZIP usually extracts into a versioned subfolder.
        # Find the actual binaries and copy them into $installDir root for a stable path.
        $netDll = Get-ChildItem -LiteralPath $extractDir -Recurse -File -Filter 'WinSCPnet.dll' | Select-Object -First 1
        if ($null -eq $netDll) {
            throw "WinSCPnet.dll not found in extracted archive."
        }

        $binDir = $netDll.Directory.FullName
        foreach ($name in @('WinSCPnet.dll', 'WinSCP.exe', 'WinSCP.com')) {
            $src = Join-Path $binDir $name
            if (Test-Path -LiteralPath $src) {
                $dest = Join-Path $installDir $name
                try {
                    Copy-Item -LiteralPath $src -Destination $dest -Force
                }
                catch {
                    throw "Failed to copy '$name' into $installDir. The existing file may be locked. Close any PowerShell sessions that used WinSCPnet.dll and retry. Details: $($_.Exception.Message)"
                }
            }
        }

        $didInstall = $true

        # Mark the installed folder as current for other scripts.
        Set-Content -LiteralPath $currentVersionFile -Value $installFolderName -Encoding ASCII
    }
    finally {
        if (Test-Path -LiteralPath $extractDir) {
            Remove-Item -LiteralPath $extractDir -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}

if ($didInstall) {
    if (-not (Test-Path -LiteralPath $winscpNet)) {
        throw "WinSCPnet.dll not found after install. Expected: $winscpNet"
    }
    if (-not (Test-Path -LiteralPath $winscpExe)) {
        throw "WinSCP.exe not found after install. Expected: $winscpExe"
    }

    Write-Host "WinSCP installed locally." -ForegroundColor Green
    if (Test-Path -LiteralPath (Join-Path $installDir 'WinSCP.com')) {
        Write-Host "  WinSCP.com:    $((Join-Path $installDir 'WinSCP.com'))"
    }
    Write-Host "  WinSCP.exe:    $winscpExe"
    Write-Host "  WinSCPnet.dll: $winscpNet"
    Write-Host "\nNext:" -ForegroundColor Yellow
    Write-Host "  Use .\\ps\\Push-FileToRemote.ps1 to upload a single file." -ForegroundColor Yellow
} else {
    Write-Host "No install performed (possibly -WhatIf)." -ForegroundColor Yellow
}
