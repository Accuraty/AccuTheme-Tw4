# Define the path to the AccuTheme.config file
$jsonPath = Join-Path -Path $PSScriptRoot -ChildPath "..\dnn\Portals\_default\Skins\AccuTheme-Tw4\AccuTheme.config"
$defaultJsonPath = Join-Path -Path $PSScriptRoot -ChildPath "..\..\src\AccuTheme-defaults.json"

# Check if the file exists
if (!(Test-Path -Path $jsonPath)) {
    Write-Host "AccuTheme.config file not found. Copying from defaults..."
    try {
        Copy-Item -Path $defaultJsonPath -Destination $jsonPath -Force
        Write-Host "AccuTheme.config copied successfully."
    }
    catch {
        Write-Error "Error copying AccuTheme-defaults.json: $($_.Exception.Message)"
        exit
    }
}

# Read the JSON content
try {
    $jsonContent = Get-Content -Path $jsonPath -Raw | ConvertFrom-Json
}
catch {
    Write-Error "Error reading or parsing AccuTheme.config: $($_.Exception.Message)"
    exit
}

# Function to prompt user with options and validate input
function Prompt-ForOption {
    param (
        [string]$SettingName,
        [object]$CurrentValue,
        [object]$Options
    )

    # Check if options are defined
    if ($Options) {
        Write-Host "$($SettingName)"
        $i = 1
        foreach ($key in $Options.PSObject.Properties | Where-Object { !$_.IsNoteProperty -and !$_.IsScriptProperty }) {
            $optionValue = $Options.$($key.Name)
            $current = if ($optionValue -eq $CurrentValue) { " (current)" } else { "" }
            Write-Host "  ${i}: $($optionValue)$current"
            $i++
        }

        while ($true) {
            $choice = Read-Host "Change $($SettingName)?"
            if ($choice -eq "") {
                Write-Host "Keeping current value: $($CurrentValue)"
                return $CurrentValue
                break
            }
            if ($choice -match "^\d+$" -and $choice -ge 1 -and $choice -le ($Options.PSObject.Properties | Where-Object { !$_.IsNoteProperty -and !$_.IsScriptProperty }).Count) {
                $selectedKey = ($Options.PSObject.Properties | Where-Object { !$_.IsNoteProperty -and !$_.IsScriptProperty })[$choice - 1].Name
                return $Options.$selectedKey
                break
            } else {
                Write-Warning "Invalid choice. Please enter a number between 1 and $(($Options.PSObject.Properties | Where-Object { !$_.IsNoteProperty -and !$_.IsScriptProperty }).Count) or leave blank to keep current."
            }
        }
    } else {
        # If no options are defined, prompt for a free-text value
        $newValue = Read-Host "Enter new value for $($SettingName) (leave blank to keep current)"
        if ($newValue -eq "") {
            Write-Host "Keeping current value: $($CurrentValue)"
            return $CurrentValue
        }
        return $newValue
    }
}

# Prompt for each setting defined under "options"
Write-Host ""  # spacing

foreach ($optProp in $jsonContent.options.PSObject.Properties) {
    $settingName = $optProp.Name
    $optionsForSetting = $optProp.Value

    # Skip non-object values just in case
    if (-not ($optionsForSetting -is [System.Management.Automation.PSObject])) {
        continue
    }

    # Get current value from settings; if missing, treat as empty
    $currentValue = $null
    if ($jsonContent.settings.PSObject.Properties.Name -contains $settingName) {
        $currentValue = $jsonContent.settings.$settingName
    }

    Write-Host ""  # blank line between settings
    $newValue = Prompt-ForOption -SettingName $settingName -CurrentValue $currentValue -Options $optionsForSetting
    if ($null -ne $newValue) {
        # Ensure the settings section has this property, then set it
        $jsonContent.settings | Add-Member -NotePropertyName $settingName -NotePropertyValue $newValue -Force
    }
}

# Convert back to JSON
$newJson = $jsonContent | ConvertTo-Json -Depth 5

# Write the updated JSON back to the file
try {
    $newJson | Out-File -FilePath $jsonPath -Encoding UTF8
    Write-Host "`nAccuTheme.config updated successfully." -ForegroundColor Green
}
catch {
    Write-Error "Error writing to AccuTheme.config: $($_.Exception.Message)"
    exit
}

# Display current settings
Write-Host "`nCurrent AccuTheme Settings:"
foreach ($prop in $jsonContent.settings.PSObject.Properties) {
    Write-Host ("  {0}: {1}" -f $prop.Name, $prop.Value) -ForegroundColor Cyan
}

Write-Host "`nImportant: settings are stored (C#) static, so they survive page load AND clearing the DNN Cache... for the settings change to take effect now; Settings > Servers > Restart Application" -ForegroundColor Yellow
