param(
    # Paths relative to the project root (one level above /ps)
    [string]$SourceRootRel = "dnn",
    [string]$TargetRootRel = "..\..\dev\dnn\dnn100200-rc1\Website",
    [string]$ConfigPathRel = "dnn\Portals\_default\Skins\AccuTheme-Tw4\AccuTheme.config"
)

Write-Host "[Watcher] Zoinks, Script starting..." -ForegroundColor Cyan

# Resolve project root from this script location: <project>\ps\AccuTheme-Watch-LocalDnn.ps1
$scriptDir   = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptDir

$SourceRoot = Resolve-Path (Join-Path $projectRoot $SourceRootRel)
$TargetRoot = Resolve-Path (Join-Path $projectRoot $TargetRootRel)
$ConfigPath = Join-Path $projectRoot $ConfigPathRel

# Optional: read AccuTheme.config to respect mode / unCache
$mode = "development"

if (Test-Path $ConfigPath) {
    try {
        $config = (Get-Content -Path $ConfigPath -Raw) | ConvertFrom-Json
        if ($config.settings) {
            if ($config.settings.mode) {
                $mode = $config.settings.mode
            }
        }
    }
    catch {
        Write-Warning "Could not read AccuTheme.config: $($_.Exception.Message)"
    }
} else {
    Write-Warning "AccuTheme.config not found at $ConfigPath"
}

if ($mode -ne "development") {
    Write-Host "AccuTheme mode is '$mode'. Watcher will not start (dev only)." -ForegroundColor Yellow
    return
}

Write-Host "DEBUG:"
Write-Host "  scriptDir:   $scriptDir"
Write-Host "  projectRoot: $projectRoot"
Write-Host "  Source:      $SourceRoot"
Write-Host "  Target:      $TargetRoot"
Write-Host "  ConfigPath:  $ConfigPath"
Write-Host "Press Ctrl+C to stop.`n"
Write-Host "Watcher is now idle and waiting for file changes..." -ForegroundColor Yellow

$ignorePatterns = @(
    '\.git($|\\)',
    '\\node_modules($|\\)',
    '\\obj($|\\)',
    '\\bin($|\\)',
    '\\App_Data($|\\)',
    '\\Logs($|\\)'
)

$fsw = New-Object System.IO.FileSystemWatcher
$fsw.Path = $SourceRoot
$fsw.IncludeSubdirectories = $true
$fsw.EnableRaisingEvents = $true
$fsw.Filter = "*.*"
Write-Host "FileSystemWatcher created. Path=$($fsw.Path), IncludeSubdirectories=$($fsw.IncludeSubdirectories)" -ForegroundColor Cyan

function Sync-File($fullPath, $sourceRoot, $targetRoot, $ignorePatterns) {
    Write-Host "[Sync-File] Invoked for: $fullPath" -ForegroundColor Cyan
    foreach ($p in $ignorePatterns) {
        if ($fullPath -match $p) {
            Write-Host "[Ignore]  $fullPath (pattern: $p)" -ForegroundColor DarkGray
            return
        }
    }

    $relPath = $fullPath.Substring($sourceRoot.Length).TrimStart('\\')
    $destPath = Join-Path $targetRoot $relPath

    $destDir = Split-Path $destPath -Parent
    if (-not (Test-Path $destDir)) {
        Write-Host "[CreateDir] $destDir" -ForegroundColor DarkCyan
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }

    Copy-Item -Path $fullPath -Destination $destPath -Force
    Write-Host "[Copied] $relPath -> $destPath" -ForegroundColor Green
}

function Remove-File($fullPath, $sourceRoot, $targetRoot, $ignorePatterns) {
    Write-Host "[Remove-File] Invoked for: $fullPath" -ForegroundColor Cyan
    foreach ($p in $ignorePatterns) {
        if ($fullPath -match $p) {
            Write-Host "[Ignore]  $fullPath (pattern: $p)" -ForegroundColor DarkGray
            return
        }
    }

    $relPath = $fullPath.Substring($sourceRoot.Length).TrimStart('\\')
    $destPath = Join-Path $targetRoot $relPath
    if (Test-Path $destPath) {
        Remove-Item $destPath -Force
        Write-Host "[Removed] $relPath ($destPath)" -ForegroundColor Red
    } else {
        Write-Host "[RemoveSkip] Not found at target: $destPath" -ForegroundColor DarkYellow
    }
}

$onChanged = Register-ObjectEvent $fsw Changed -SourceIdentifier "DnnLocalSyncChanged" -Action {
    $fullPath = $Event.SourceEventArgs.FullPath
    $change   = $Event.SourceEventArgs.ChangeType
    Write-Host "[Changed] $fullPath ($change)" -ForegroundColor DarkYellow

    if (-not (Test-Path $fullPath)) {
        Write-Host "[ChangedSkip] Source no longer exists: $fullPath" -ForegroundColor DarkGray
        return
    }

    Write-Host "[ChangedInline] Using SourceRoot=$SourceRoot, TargetRoot=$TargetRoot" -ForegroundColor DarkCyan

    $prefix = $SourceRoot.TrimEnd('\\') + '\\'
    if ($fullPath.StartsWith($prefix, [StringComparison]::OrdinalIgnoreCase)) {
        $relPath = $fullPath.Substring($prefix.Length)
    } else {
        $relPath = Split-Path $fullPath -Leaf
    }

    Write-Host "[ChangedInline] relPath = $relPath" -ForegroundColor DarkCyan

    $destPath = Join-Path $TargetRoot $relPath
    Write-Host "[ChangedInline] destPath = $destPath" -ForegroundColor DarkCyan

    $destDir = Split-Path $destPath -Parent
    if (-not (Test-Path $destDir)) {
        Write-Host "[CreateDir] $destDir" -ForegroundColor DarkCyan
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }

    Write-Host "[CopyInline] $relPath -> $destPath" -ForegroundColor Green
    Copy-Item -Path $fullPath -Destination $destPath -Force
}

$onCreated = Register-ObjectEvent $fsw Created -SourceIdentifier "DnnLocalSyncCreated" -MessageData @{
    SourceRoot     = $SourceRoot
    TargetRoot     = $TargetRoot
    IgnorePatterns = $ignorePatterns
} -Action {
    $fullPath = $Event.SourceEventArgs.FullPath
    Write-Host "[Created] $fullPath" -ForegroundColor Green
    $ctx = $Event.MessageData
    Sync-File $fullPath $ctx.SourceRoot $ctx.TargetRoot $ctx.IgnorePatterns
}

$onRenamed = Register-ObjectEvent $fsw Renamed -SourceIdentifier "DnnLocalSyncRenamed" -MessageData @{
    SourceRoot     = $SourceRoot
    TargetRoot     = $TargetRoot
    IgnorePatterns = $ignorePatterns
} -Action {
    $oldPath = $Event.SourceEventArgs.OldFullPath
    $fullPath = $Event.SourceEventArgs.FullPath
    Write-Host "[Renamed] $oldPath -> $fullPath" -ForegroundColor Magenta
    $ctx = $Event.MessageData
    Remove-File $oldPath $ctx.SourceRoot $ctx.TargetRoot $ctx.IgnorePatterns
    if (Test-Path $fullPath) {
        Sync-File $fullPath $ctx.SourceRoot $ctx.TargetRoot $ctx.IgnorePatterns
    }
}

$onDeleted = Register-ObjectEvent $fsw Deleted -SourceIdentifier "DnnLocalSyncDeleted" -MessageData @{
    SourceRoot     = $SourceRoot
    TargetRoot     = $TargetRoot
    IgnorePatterns = $ignorePatterns
} -Action {
    $fullPath = $Event.SourceEventArgs.FullPath
    Write-Host "[Deleted] $fullPath" -ForegroundColor Red
    $ctx = $Event.MessageData
    Remove-File $fullPath $ctx.SourceRoot $ctx.TargetRoot $ctx.IgnorePatterns
}

try {
    while ($true) {
        Start-Sleep -Seconds 1
    }
}
finally {
    Unregister-Event "DnnLocalSyncChanged" -ErrorAction SilentlyContinue
    Unregister-Event "DnnLocalSyncCreated" -ErrorAction SilentlyContinue
    Unregister-Event "DnnLocalSyncRenamed" -ErrorAction SilentlyContinue
    Unregister-Event "DnnLocalSyncDeleted" -ErrorAction SilentlyContinue
    $fsw.Dispose()
}
