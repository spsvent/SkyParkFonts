# --- Script to download and install fonts from GitHub ---

# Create a temporary directory for the downloads
$TempDir = "$env:TEMP\CorpFonts"
if (-not (Test-Path $TempDir)) {
    New-Item -Path $TempDir -ItemType Directory
}

# Destination for fonts and registry path
$FontDir = "$env:windir\Fonts"
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"

# Array of font URLs from your GitHub repo
$FontUrls = @(
    "https://raw.githubusercontent.com/spsvent/SkyParkFonts/main/Avenir-Black.otf",
    "https://raw.githubusercontent.com/spsvent/SkyParkFonts/main/Avenir-Book.otf",
    "https://raw.githubusercontent.com/spsvent/SkyParkFonts/main/Avenir-Heavy.otf",
    "https://raw.githubusercontent.com/spsvent/SkyParkFonts/main/Avenir-Roman.otf",
    "https://raw.githubusercontent.com/spsvent/SkyParkFonts/main/DIN-Condensed-Bold.otf",
    "https://raw.githubusercontent.com/spsvent/SkyParkFonts/main/Proxima%20Nova%20Alt%20Bold.otf",
    "https://raw.githubusercontent.com/spsvent/SkyParkFonts/main/Proxima%20Nova%20Alt%20Light.otf",
    "https://raw.githubusercontent.com/spsvent/SkyParkFonts/main/Proxima%20Nova%20Alt%20Regular.otf",
    "https://raw.githubusercontent.com/spsvent/SkyParkFonts/main/ProximaNova-Bold.otf",
    "https://raw.githubusercontent.com/spsvent/SkyParkFonts/main/ProximaNova-Light.otf",
    "https://raw.githubusercontent.com/spsvent/SkyParkFonts/main/ProximaNova-Regular.otf",
    "https://raw.githubusercontent.com/spsvent/SkyParkFonts/main/ProximaNova-Semibold.otf"
)

# Corresponding Font Names for the registry
# To verify, right-click the .otf file in Windows > Properties > Details > Title
$FontNames = @{
    "Avenir-Black.otf"           = "Avenir Black (OpenType)";
    "Avenir-Book.otf"            = "Avenir Book (OpenType)";
    "Avenir-Heavy.otf"           = "Avenir Heavy (OpenType)";
    "Avenir-Roman.otf"           = "Avenir Roman (OpenType)";
    "DIN-Condensed-Bold.otf"     = "DIN Condensed Bold (OpenType)";
    "Proxima Nova Alt Bold.otf"  = "Proxima Nova Alt Bold (OpenType)";
    "Proxima Nova Alt Light.otf" = "Proxima Nova Alt Light (OpenType)";
    "Proxima Nova Alt Regular.otf" = "Proxima Nova Alt Regular (OpenType)";
    "ProximaNova-Bold.otf"       = "Proxima Nova Bold (OpenType)";
    "ProximaNova-Light.otf"      = "Proxima Nova Light (OpenType)";
    "ProximaNova-Regular.otf"    = "Proxima Nova Regular (OpenType)";
    "ProximaNova-Semibold.otf"   = "Proxima Nova Semibold (OpenType)";
}


Write-Host "Starting font installation from the web..."

foreach ($Url in $FontUrls) {
    # Get the filename from the URL, decoding any special characters like '%20'
    $FileName = [System.IO.Path]::GetFileName([System.Net.WebUtility]::UrlDecode($Url))
    $TempFile = Join-Path $TempDir $FileName
    $DestFile = Join-Path $FontDir $FileName

    try {
        # Download the file
        Write-Host "Downloading $FileName..."
        Invoke-WebRequest -Uri $Url -OutFile $TempFile
        
        # Install the font
        Write-Host "Installing $FileName..."
        Copy-Item -Path $TempFile -Destination $DestFile -Force
        
        # Register the font
        $FontName = $FontNames[$FileName]
        if ($FontName) {
            New-ItemProperty -Path $RegPath -Name $FontName -PropertyType String -Value $FileName -Force | Out-Null
            Write-Host "Registered '$FontName'."
        } else {
            Write-Host "WARNING: Font name for '$FileName' not found in the script. It may not be available until a reboot."
        }
    }
    catch {
        Write-Host "ERROR: Failed to process '$FileName'. Details: $_"
    }
}

# Clean up the temporary directory
Write-Host "Cleaning up temporary files..."
Remove-Item -Path $TempDir -Recurse -Force

Write-Host "Font installation script finished."