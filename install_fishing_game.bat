@echo off
setlocal EnableDelayedExpansion
color 0A
title Fishing Game - Automatic Installer

echo ========================================
echo    FISHING GAME - AUTO INSTALLER
echo ========================================
echo.

REM Check if Python is installed
echo [1/5] Checking for Python installation...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python not found! Downloading Python 3.12...
    echo.
    
    REM Download Python installer
    powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe' -OutFile 'python_installer.exe'}"
    
    if exist python_installer.exe (
        echo Installing Python... Please follow the installer prompts.
        echo IMPORTANT: Make sure to check "Add Python to PATH"!
        echo.
        start /wait python_installer.exe /passive InstallAllUsers=1 PrependPath=1 Include_pip=1
        del python_installer.exe
        
        echo.
        echo Python installed! Please restart this installer.
        pause
        exit
    ) else (
        echo Failed to download Python installer!
        echo Please download Python manually from https://www.python.org/downloads/
        pause
        exit /b 1
    )
) else (
    python --version
    echo Python is already installed!
)
echo.

REM Upgrade pip
echo [2/5] Upgrading pip...
python -m pip install --upgrade pip --quiet
echo pip upgraded successfully!
echo.

REM Install colorama
echo [3/5] Installing colorama library...
python -m pip install colorama --quiet
if %errorlevel% neq 0 (
    echo Failed to install colorama!
    pause
    exit /b 1
)
echo colorama installed successfully!
echo.

REM Check if fishgame.py exists
echo [4/5] Checking for fishgame.py...
if not exist fishgame.py (
    echo fishgame.py not found in current directory!
    echo Please place fishgame.py in the same folder as this installer.
    pause
    exit /b 1
)
echo fishgame.py found!
echo.

REM Create launcher script
echo [5/5] Creating game launcher...
(
echo @echo off
echo title Fishing Game
echo python fishgame.py
echo pause
) > play_fishing_game.bat
echo Launcher created: play_fishing_game.bat
echo.

REM Create desktop shortcut (optional)
echo Would you like to create a desktop shortcut? (Y/N)
set /p create_shortcut="> "
if /i "!create_shortcut!"=="Y" (
    powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%USERPROFILE%\Desktop\Fishing Game.lnk'); $Shortcut.TargetPath = '%CD%\play_fishing_game.bat'; $Shortcut.WorkingDirectory = '%CD%'; $Shortcut.IconLocation = 'shell32.dll,101'; $Shortcut.Save()"
    echo Desktop shortcut created!
    echo.
)

echo ========================================
echo    INSTALLATION COMPLETE!
echo ========================================
echo.
echo You can now run the game using:
echo   1. Double-click "play_fishing_game.bat"
echo   2. Or the desktop shortcut (if created)
echo   3. Or run: python fishgame.py
echo.
echo Press any key to launch the game now...
pause >nul

python fishgame.py