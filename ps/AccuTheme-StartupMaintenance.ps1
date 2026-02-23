<#
.SYNOPSIS
Runs a startup maintenance command on folder open, but only after a cooldown period.

.DESCRIPTION
This script is designed for VS Code task automation (runOn: folderOpen).
It tracks the last successful run in a JSON state file and skips execution
until the configured cooldown has elapsed.

.PARAMETER CooldownDays
Number of days to wait before running maintenance again.
Default: 10

.PARAMETER StateFileRelPath
Path (relative to workspace root) to store state JSON.
Default: .vscode/startup-maintenance-state.json

.PARAMETER CommandParts
Command and arguments to execute.
Default: npx update-browserslist-db@latest

.EXAMPLE
pwsh.exe -NoProfile -File .\ps\AccuTheme-StartupMaintenance.ps1

.EXAMPLE
pwsh.exe -NoProfile -File .\ps\AccuTheme-StartupMaintenance.ps1 -CooldownDays 10 -StateFileRelPath ".vscode/startup-maintenance-state.json" -CommandParts npx update-browserslist-db@latest

.EXAMPLE
pwsh.exe -NoProfile -File .\ps\AccuTheme-StartupMaintenance.ps1 -CooldownDays 1 -CommandParts pwsh -NoProfile -Command "Write-Host 'Maintenance test run'"
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [ValidateRange(0, 3650)]
    [int]$CooldownDays = 10,

    [Parameter(Mandatory = $false)]
    [string]$StateFileRelPath = ".vscode/startup-maintenance-state.json",

    [Parameter(Mandatory = $false)]
    [string[]]$CommandParts = @("npx", "update-browserslist-db@latest")
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$workspaceRoot = Split-Path -Parent $scriptDir
$stateFile = Join-Path $workspaceRoot $StateFileRelPath
$nowUtc = [DateTime]::UtcNow

if ($null -eq $CommandParts -or $CommandParts.Count -eq 0) {
    Write-Warning "No command configured. Nothing to run."
    return
}

$stateDir = Split-Path -Parent $stateFile
if (-not (Test-Path -Path $stateDir)) {
    New-Item -ItemType Directory -Path $stateDir -Force | Out-Null
}

$lastRunUtc = $null
if (Test-Path -Path $stateFile) {
    try {
        $state = Get-Content -Path $stateFile -Raw | ConvertFrom-Json
        if ($state.lastRunUtc) {
            $lastRunUtc = [DateTimeOffset]::Parse(
                $state.lastRunUtc,
                [System.Globalization.CultureInfo]::InvariantCulture,
                [System.Globalization.DateTimeStyles]::RoundtripKind
            ).UtcDateTime
        }
    }
    catch {
        Write-Warning "State file exists but could not be parsed. Recreating after this run."
    }
}

if ($null -ne $lastRunUtc) {
    $nextRunUtc = $lastRunUtc.AddDays($CooldownDays)
    if ($nowUtc -lt $nextRunUtc) {
        $remaining = [Math]::Max(0, [Math]::Ceiling(($nextRunUtc - $nowUtc).TotalDays))
        Write-Host "[StartupMaintenance] Skipped. Last run: $($lastRunUtc.ToString('u')); next run after: $($nextRunUtc.ToString('u')); remaining: $remaining day(s)." -ForegroundColor DarkYellow
        return
    }
}

$cmd = $CommandParts[0]
$cmdArgs = @()
if ($CommandParts.Count -gt 1) {
    $cmdArgs = $CommandParts[1..($CommandParts.Count - 1)]
}

Write-Host "[StartupMaintenance] Running command: $($CommandParts -join ' ')" -ForegroundColor Cyan

$exitCode = 0
$invocationSucceeded = $true
Push-Location $workspaceRoot
try {
    & $cmd @cmdArgs
    $invocationSucceeded = $?
    if ($null -ne $LASTEXITCODE) {
        $exitCode = $LASTEXITCODE
    }
    elseif (-not $invocationSucceeded) {
        $exitCode = 1
    }
}
catch {
    $invocationSucceeded = $false
    $exitCode = 1
    Write-Warning "[StartupMaintenance] Command invocation failed: $($_.Exception.Message)"
}
finally {
    Pop-Location
}

if (-not $invocationSucceeded -and $exitCode -eq 0) {
    $exitCode = 1
    }

if ($exitCode -ne 0) {
    Write-Warning "[StartupMaintenance] Command failed with exit code $exitCode. Timestamp not updated."
    exit $exitCode
}

$newState = [PSCustomObject]@{
    lastRunUtc = $nowUtc.ToString("o")
    cooldownDays = $CooldownDays
    lastCommand = ($CommandParts -join " ")
}

$newState | ConvertTo-Json -Depth 3 | Set-Content -Path $stateFile -Encoding UTF8
Write-Host "[StartupMaintenance] Completed. Next eligible run in $CooldownDays day(s)." -ForegroundColor Green
