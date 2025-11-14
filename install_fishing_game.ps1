# Fishing Game - GitHub Auto-Installer (PowerShell)
# Run this with: powershell -ExecutionPolicy Bypass -File install_from_github.ps1

$Host.UI.RawUI.WindowTitle = "Fishing Game - GitHub Installer"
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Green"
Clear-Host

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   FISHING GAME - GITHUB INSTALLER" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "This will download and setup the game from:" -ForegroundColor Yellow
Write-Host "github.com/Nokoiscool/Fishing-game" -ForegroundColor White
Write-Host ""
Read-Host "Press Enter to continue"

# Create game directory
$GameDir = Join-Path $env:USERPROFILE "Desktop\Fishing-Game"
Write-Host "[1/6] Creating game directory..." -ForegroundColor Yellow

if (-not (Test-Path $GameDir)) {
    New-Item -ItemType Directory -Path $GameDir -Force | Out-Null
    Write-Host "✓ Created: $GameDir" -ForegroundColor Green
} else {
    Write-Host "✓ Directory already exists: $GameDir" -ForegroundColor Green
}

Set-Location $GameDir
Write-Host ""

# Check Python installation
Write-Host "[2/6] Checking for Python installation..." -ForegroundColor Yellow
$pythonInstalled = $false

try {
    $pythonVersion = python --version 2>&1
    if ($pythonVersion -match "Python (\d+\.\d+\.\d+)") {
        Write-Host "✓ Python $($matches[1]) is installed!" -ForegroundColor Green
        $pythonInstalled = $true
    }
} catch {
    $pythonInstalled = $false
}

if (-not $pythonInstalled) {
    Write-Host "✗ Python not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Downloading Python 3.12..." -ForegroundColor Yellow
    
    $pythonUrl = "https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe"
    $installerPath = "$env:TEMP\python_installer.exe"
    
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Write-Host "Downloading... (this may take a moment)" -ForegroundColor Cyan
        Invoke-WebRequest -Uri $pythonUrl -OutFile $installerPath -UseBasicParsing
        
        Write-Host "✓ Download complete!" -ForegroundColor Green
        Write-Host ""
        Write-Host "Installing Python..." -ForegroundColor Yellow
        Write-Host "This will install Python with PATH enabled" -ForegroundColor Cyan
        
        Start-Process -FilePath $installerPath -ArgumentList "/passive InstallAllUsers=1 PrependPath=1 Include_pip=1" -Wait
        Remove-Item $installerPath -Force
        
        Write-Host "✓ Python installed!" -ForegroundColor Green
        Write-Host ""
        Write-Host "Please restart this installer to continue." -ForegroundColor Yellow
        Read-Host "Press Enter to exit"
        exit
    } catch {
        Write-Host "✗ Failed to download/install Python!" -ForegroundColor Red
        Write-Host "Error: $_" -ForegroundColor Red
        Write-Host "Please download manually from: https://www.python.org/downloads/" -ForegroundColor Yellow
        Read-Host "Press Enter to exit"
        exit 1
    }
}
Write-Host ""

# Download fishgame.py from GitHub
Write-Host "[3/6] Downloading fishgame.py from GitHub..." -ForegroundColor Yellow

try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $gameUrl = "https://raw.githubusercontent.com/Nokoiscool/Fishing-game/main/fishgame.py"
    
    Write-Host "Downloading from: $gameUrl" -ForegroundColor Cyan
    Invoke-WebRequest -Uri $gameUrl -OutFile "fishgame.py" -UseBasicParsing
    
    if (Test-Path "fishgame.py") {
        $fileSize = (Get-Item "fishgame.py").Length
        Write-Host "✓ fishgame.py downloaded successfully! ($([math]::Round($fileSize/1KB, 2)) KB)" -ForegroundColor Green
    } else {
        throw "File not found after download"
    }
} catch {
    Write-Host "✗ Failed to download fishgame.py!" -ForegroundColor Red
    Write-Host "Error: $_" -ForegroundColor Red
    Write-Host "Please check your internet connection and try again." -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host ""

# Upgrade pip
Write-Host "[4/6] Upgrading pip..." -ForegroundColor Yellow
try {
    python -m pip install --upgrade pip --quiet --disable-pip-version-check 2>$null
    Write-Host "✓ pip upgraded successfully!" -ForegroundColor Green
} catch {
    Write-Host "⚠ Warning: Could not upgrade pip (not critical)" -ForegroundColor DarkYellow
}
Write-Host ""

# Install colorama
Write-Host "[5/6] Installing colorama library..." -ForegroundColor Yellow
try {
    python -m pip install colorama --quiet --disable-pip-version-check
    Write-Host "✓ colorama installed successfully!" -ForegroundColor Green
} catch {
    Write-Host "⚠ Trying user installation..." -ForegroundColor DarkYellow
    try {
        python -m pip install --user colorama
        Write-Host "✓ colorama installed successfully!" -ForegroundColor Green
    } catch {
        Write-Host "✗ Failed to install colorama!" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
}
Write-Host ""

# Create launcher
Write-Host "[6/6] Creating game launcher..." -ForegroundColor Yellow

$launcherContent = @"
@echo off
title Fishing Game
cd /d "%~dp0"
cls
echo Starting Fishing Game...
echo.
python fishgame.py
if errorlevel 1 (
    echo.
    echo An error occurred while running the game!
    echo Make sure Python and colorama are installed.
    pause
)
"@
Set-Content -Path "Play Fishing Game.bat" -Value $launcherContent
Write-Host "✓ Launcher created: Play Fishing Game.bat" -ForegroundColor Green

# Create update script
$updateContent = @"
@echo off
title Fishing Game - Updater
echo Downloading latest version from GitHub...
echo.
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Nokoiscool/Fishing-game/main/fishgame.py' -OutFile 'fishgame.py' -UseBasicParsing"
if exist fishgame.py (
    echo.
    echo Update successful!
) else (
    echo.
    echo Update failed! Check your internet connection.
)
echo.
pause
"@
Set-Content -Path "Update Game.bat" -Value $updateContent
Write-Host "✓ Update script created: Update Game.bat" -ForegroundColor Green
Write-Host ""

# Create desktop shortcut
$createShortcut = Read-Host "Would you like to create a desktop shortcut? (Y/N)"
if ($createShortcut -eq "Y" -or $createShortcut -eq "y") {
    try {
        $WshShell = New-Object -ComObject WScript.Shell
        $Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\Play Fishing Game.lnk")
        $Shortcut.TargetPath = "$GameDir\Play Fishing Game.bat"
        $Shortcut.WorkingDirectory = $GameDir
        $Shortcut.IconLocation = "shell32.dll,101"
        $Shortcut.Description = "Play Fishing Game"
        $Shortcut.Save()
        Write-Host "✓ Desktop shortcut created!" -ForegroundColor Green
    } catch {
        Write-Host "⚠ Could not create desktop shortcut" -ForegroundColor DarkYellow
    }
}
Write-Host ""

# Installation complete
Write-Host "========================================" -ForegroundColor Green
Write-Host "   INSTALLATION COMPLETE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Game installed to: " -ForegroundColor Cyan -NoNewline
Write-Host $GameDir -ForegroundColor White
Write-Host ""
Write-Host "You can now run the game using:" -ForegroundColor Cyan
Write-Host "  1. Double-click 'Play Fishing Game.bat'" -ForegroundColor White
Write-Host "  2. Desktop shortcut (if created)" -ForegroundColor White
Write-Host "  3. Or run: python fishgame.py" -ForegroundColor White
Write-Host ""
Write-Host "To update the game in the future:" -ForegroundColor Cyan
Write-Host "  - Run 'Update Game.bat'" -ForegroundColor White
Write-Host ""

$launch = Read-Host "Would you like to launch the game now? (Y/N)"
if ($launch -eq "Y" -or $launch -eq "y") {
    Clear-Host
    python fishgame.py
}
