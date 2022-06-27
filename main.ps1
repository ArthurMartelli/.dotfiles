#Requires -RunAsAdministrator

Set-Location $HOME

function setupPC {
    # Basic configuration for windows

    # Being able to run scripts
    Set-ExecutionPolicy "RemoteSigned"

    $reg_settings = @(
        @{
            path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
            keys = @(
                @{
                    name    = "AppsUseLightTheme"
                    value   = 1
                    comment = "Enabled Dark Mode"
                }
            )
        },
        @{
            path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
            keys = @(
                @{
                    name    = "TaskbarAl"
                    value   = 0
                    comment = "Align taskbar to the left"
                },
                @{
                    name    = "HideFileExt"
                    value   = 0
                    comment = "Show file extensions"
                },
                @{
                    name    = "Hidden"
                    value   = 1
                    comment = "Show hidden files"
                },
                @{
                    name    = "LaunchTo"
                    value   = 1
                    comment = "Launch File explorer on quick access (0) or This PC (1) [Set to 1]"
                },
                @{
                    name    = "IconsOnly"
                    value   = 1
                    comment = "Only show icons, not thumbnails"
                },
                @{
                    name    = "DontPrettyPath"
                    value   = 1 
                    comment = "Prevent case change on filename"
                },
                @{
                    name    = "TaskbarGlomLevel"
                    value   = 1
                    comment = "Always combine items in taskbar"
                },
                @{
                    name    = "Start_TrackDocs"
                    value   = 0
                    comment = "Dont track docs on start menu"
                },
                @{
                    name    = "ShowTaskViewButton"
                    value   = 0
                    comment = "Hide the task view button on the taskbar"
                },
                @{
                    name    = "TaskbarDa"
                    value   = 0
                    comment = "Hide the widgets button on the taskbar"
                },
                @{
                    name    = "TaskbarMn"
                    value   = 0
                    comment = "Hide the chat button on the taskbar"
                }
            
            )
        },
        @{
            path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search"
            keys = @(
                @{
                    name    = "SearchboxTaskbarMode"
                    value   = 0
                    comment = "Hide search button on the taskbar"
                }
            )
        }
    )

    foreach ($item in $reg_settings) {
        $path = $item.path
        $keys = $item.keys

        foreach ($key in $keys) {
            Write-Output $key.comment
            Set-ItemProperty -Path $path -Name $key.name -Value $key.value -Type Dword -Force
        }
    }
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