@echo off
:: Windows Terminal customization bootstrap
:: Run as Administrator

echo ===========================================
echo  Setting up terminal environment...
echo ===========================================

:: Ensure winget is available
where winget >nul 2>nul
if %errorlevel% neq 0 (
    echo winget not found! Please install Windows Package Manager first.
    pause
    exit /b
)

:: Update winget sources
echo Updating winget sources...
winget source update

:: Install Nerd Font (SpaceMono)
echo Installing SpaceMono Nerd Font...
winget install -e --id NerdFonts.SpaceMono

:: Install Git
echo Installing Git...
winget install -e --id Git.Git

:: Install Oh My Posh
echo Installing Oh My Posh...
winget install -e --id JanDeDobbeleer.OhMyPosh

:: Install Winfetch
echo Installing Winfetch...
winget install -e --id lsdsoftware.Winfetch

:: (Optional) Install PowerShell Core (latest)
echo Installing PowerShell 7...
winget install -e --id Microsoft.PowerShell

:: Download Belafonte Night theme for Windows Terminal
echo Downloading Belafonte Night theme...
powershell -Command ^
  "Invoke-WebRequest -Uri https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/windowsterminal/Belafonte%20Night.json -OutFile $env:USERPROFILE\Belafonte-Night.json"

:: Add Belafonte Night scheme and customize settings
echo Customizing Windows Terminal settings...
powershell -Command ^
  "$settingsPath = \"$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json\"; " ^
  "$settings = Get-Content $settingsPath -Raw | ConvertFrom-Json; " ^
  "$scheme = Get-Content \"$env:USERPROFILE\Belafonte-Night.json\" -Raw | ConvertFrom-Json; " ^
  "$settings.schemes += $scheme; " ^
  "foreach ($profile in $settings.profiles.list) { " ^
  "  if ($profile.name -eq 'PowerShell' -or $profile.name -eq 'Windows PowerShell') { " ^
  "    $profile.colorScheme = 'Belafonte Night'; " ^
  "    $profile.cursorShape = 'underscore'; " ^
  "    $profile.useAcrylic = $true; " ^
  "    $profile.acrylicOpacity = 0.6; " ^
  "    $profile.retroTerminalEffect = $true; " ^
  "    $profile.font.face = 'SpaceMono Nerd Font'; " ^
  "  } " ^
  "} " ^
  "$settings | ConvertTo-Json -Depth 32 | Set-Content $settingsPath"

:: Set up Oh My Posh with Powerlevel9k
echo Configuring Oh My Posh...
powershell -Command ^
  "if (-not (Test-Path $PROFILE)) { New-Item -Path $PROFILE -ItemType File -Force }; " ^
  "Add-Content $PROFILE 'oh-my-posh init pwsh --config (oh-my-posh get shell --shell pwsh --config powerlevel9k) | Invoke-Expression'"

echo ===========================================
echo   All done! Restart Windows Terminal.
echo ===========================================

pause
