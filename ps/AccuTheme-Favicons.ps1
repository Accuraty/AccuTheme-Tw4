# put your valid source image (see reminders below) in
# src/media/favicon and replace the filename right here
# best practice: no spaces in your filename
$fileName = 'favicon.svg'
#            ^^^^^^^^^^^

### no need to change anything below this line
### no need to change anything below this line
### no need to change anything below this line

### REMINDERS
# source image should be square (1:1 aspect ratio)
# high qualtiy SVG is ideal
# for PNG; min size 260x260, but 512x512 is better, 800x800 is best
# transparent background is recommended
# filename: dashes instead of spaces, never underscores

# define reusable source / destination paths (resolved relative to script)
$sourcePath = Join-Path $PSScriptRoot '..\src\media\favicon'
$destPath   = Join-Path $PSScriptRoot '..\dnn\Portals\_default\Skins\AccuTheme-Tw4\dist\favicons'

# ensure favicon-links exists (start empty)
Set-Content -Path (Join-Path $sourcePath 'favicon-links.htm') -Value '' -Force

# https://realfavicongenerator.net/favicon-generator/node-cli
# Option 1: write to current folder /assets
# npx realfavicon generate <src> <settings.json> <markups.json> <outdir>
# Option 2: write to final /dist destination (used here)
npx realfavicon generate (Join-Path $sourcePath $fileName) (Join-Path $sourcePath 'settings.json') (Join-Path $sourcePath 'markups.json') $destPath

# inject generated markups into the links file in sourcePath
npx realfavicon inject (Join-Path $sourcePath 'markups.json') $sourcePath (Join-Path $sourcePath 'favicon-links.htm')

### below was written by A.I. and worked, I read through it but made no changes 20251031 JRF

# Starting here: extract the <head>...</head> fragment from the generated file,
# convert to a single-line C# verbatim string literal and replace the
# string Favicons assignment line in meta.ascx.
$faviconLinks = Join-Path $sourcePath 'favicon-links.htm'
if (-not (Test-Path $faviconLinks)) {
    Write-Warning "Favicon links file not found: $faviconLinks"
    return
}

$html = Get-Content -Raw -LiteralPath $faviconLinks

# Extract content between <head> and </head> (case-insensitive, singleline)
$match = [regex]::Match($html, '(?is)<head[^>]*>(.*?)</head>')
if (-not $match.Success) {
    Write-Warning "No <head>...</head> section found in $faviconLinks"
    $headContent = ''
} else {
    $headContent = $match.Groups[1].Value
}

# Normalize whitespace into a single-line string
$oneLine = $headContent -replace '\r?\n', ' ' -replace '\s{2,}', ' ' -replace '^\s+|\s+$',''

# Prepare C# verbatim string literal: double any existing double-quotes
$escaped = $oneLine -replace '"', '""'

# Build replacement assignment line (verbatim string literal) e.g.
# string Favicons = @"<link ...>";
$replacementBody = 'string Favicons = @"' + $escaped + '";'

# Paths
$root = Join-Path $PSScriptRoot '..'
$metaPath = Join-Path $root 'dnn\Portals\_default\Skins\AccuTheme-Tw4\controls\meta.ascx'
if (-not (Test-Path $metaPath)) {
    Write-Warning "meta.ascx not found: $metaPath"
    return
}

$metaText = Get-Content -Raw -LiteralPath $metaPath

# Replace the entire line that assigns Favicons (preserve leading indentation).
# Pattern matches a whole line like: [whitespace]string Favicons = ...;
$metaText = [regex]::Replace(
    $metaText,
    '(^[ \t]*)string\s+Favicons\s*=.*?;\s*$',
    { param($m) ($m.Groups[1].Value + $replacementBody) },
    [System.Text.RegularExpressions.RegexOptions]::Multiline
)

# Save the updated file (use UTF8)
Set-Content -LiteralPath $metaPath -Value $metaText -Encoding UTF8

Write-Host "Inserted favicons markup into meta.ascx (replaced the entire Favicons assignment line)."
# done
