#Requires -RunAsAdministrator

Set-Location $HOME

function setupPC {
    # Basic configuration for windows

    # Being able to run scripts
    Set-ExecutionPolicy "RemoteSigned"

    $theme_reg_path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    $explorer_reg_path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    $search_reg_path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search"

    # Enable Dark Mode
    Set-ItemProperty -Path $theme_reg_path  -Name "AppsUseLightTheme" -Value 0 -Type Dword -Force

    # Align taskbar to the left
    Set-ItemProperty -Path $explorer_reg_path -Name "TaskbarAl" -Value 0 -Type Dword -Force
    
    # Show file extensions
    Set-ItemProperty -Path $explorer_reg_path -Name "HideFileExt" -Value 0 -Type Dword -Force
    
    # Show hidden files
    Set-ItemProperty -Path $explorer_reg_path -Name "Hidden" -Value 1 -Type Dword -Force
    
    # Launch File explorer on quick access (0) or This PC (1)
    Set-ItemProperty -Path $explorer_reg_path -Name "LaunchTo" -Value 1 -Type Dword -Force

    # Only show icons, not thumbnails
    Set-ItemProperty -Path $explorer_reg_path -Name "IconsOnly" -Value 1 -Type Dword -Force
    
    # Prevent case change on filename
    Set-ItemProperty -Path $explorer_reg_path -Name "DontPrettyPath" -Value 1 -Type Dword -Force

    # Always combine items in taskbar
    Set-ItemProperty -Path $explorer_reg_path -Name "TaskbarGlomLevel" -Value 1 -Type Dword -Force

    # Dont track docs on start menu
    Set-ItemProperty -Path $explorer_reg_path -Name "Start_TrackDocs" -Value 0 -Type Dword -Force
    
    # Hide the task view button on the taskbar
    Set-ItemProperty -Path $explorer_reg_path -Name "ShowTaskViewButton" -Value 0 -Type Dword -Force
    
    # Hide the widgets button on the taskbar
    Set-ItemProperty -Path $explorer_reg_path -Name "TaskbarDa" -Value 0 -Type Dword -Force
    
    # Hide the chat button on the taskbar
    Set-ItemProperty -Path $explorer_reg_path -Name "TaskbarMn" -Value 0 -Type Dword -Force

    # Hide search button on the taskbar
    Set-ItemProperty -Path $search_reg_path -Name "SearchboxTaskbarMode" -Value 0 -Type Dword -Force
}

function installWinGet {
    $hasPackageManager = Get-AppPackage -Name "Microsoft.DesktopAppInstaller"

    if (!$hasPackageManager) {
        Add-AppxPackage -Path "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
		
        $releases_url = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"

        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $releases = Invoke-RestMethod -uri "$($releases_url)"
        $latestRelease = $releases.assets | Where-Object { $_.browser_download_url.EndsWith("msixbundle") } | Select-Object -First 1
	
        Add-AppxPackage -Path $latestRelease.browser_download_url
    }
}

function setupChocolatey {
    # Setup chocolatey package manager
    Write-Output "Installing Chocolatey"
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    Invoke-Expression "choco feature enable -n = allowGlobalConfirmation"
    Write-Output "Chocolatey is ready to begin installing packages"

    # Sets up Update-SessionEnvironment
    $env:ChocolateyInstall = Convert-Path "$((Get-Command choco).Path)\..\.."  
    Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
    Update-SessionEnvironment
}

function setupGit {
    Invoke-Expression "choco install git"
    Update-SessionEnvironment
    Invoke-Expression "git clone 'https://github.com/ArthurMartelli/.dotfiles' $HOME\.dotfiles"
}

function runScripts {
    # Run all scripts in .\scripts\*.ps1
    Get-ChildItem -Path "$HOME\.dotfiles\scripts\*.ps1" | Foreach-Object {
        Pause
        Write-Output $_.FullName
        Update-SessionEnvironment
    }
}

function createSymlink {
    # Make sybmbolik links for files
    Write-Output "Creating Symbolic Link"
    Invoke-Expression "Python scripts/setup.py"
    Update-SessionEnvironment
}

# Configure some password manager

function setupPrograms {
    # Sets up programs (only bitwarden at the moment)
    Write-Output "Login into bitwarden"
    Invoke-Expression "bw login"
    Update-SessionEnvironment
}

function Main {
    setupPC
    installWinGet
    setupChocolatey
    setupGit
    runScripts
    createSymlink
    setupPrograms
}

Main