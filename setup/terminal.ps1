#Requires -RunAsAdministrator

Write-Host "Setting up custom terminal"

## Font installation
function installRequirements {
    $fonts = @(
        "cascadia-code-nerd-font",
        "cascadiacode",
        "cascadiamono",
        "cascadiacodepl",
        "cascadiamonopl"
    )
    
    foreach ($font in $fonts) {
        Write-Output ("Installing font ${font}")
        Invoke-Expression "choco install ${font}"
    }

    $programs = @(
        @{
            name    = "Oh My Posh"
            install = "choco install oh-my-posh"
        },
        @{
            name    = "Terminal icons"
            install = "Install-Module -Name Terminal-Icons -Repository PSGallery"
        }
    )
    
    foreach ($item in $programs) {
        Invoke-Expression $item.install
    }
}

function setupTerminals {
    $terminals = @(
        @{
            name = "wt"
            path = "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
            src  = "$HOME\.wtconfig"
        },
        @{
            name = "vscode"
            path = "$HOME\AppData\Roaming\Code\User\settings.json"
            src  = "$HOME\.vscodeconfig"
        },
        @{
            name = "profile"
            path = $PROFILE
            src  = "$HOME\.profile"
        }
    )

    foreach ($terminal in $terminals) {
        New-Item -ItemType SymbolicLink -Path $terminal.path -Target $terminal.src -Force
    }
}

function setupProfile {
    # run 'Get-PoshThemes' in powershell to print the themes or look them at https://ohmyposh.dev/docs/themes/
    $THEME = 'nordtron'
    
    $profile_content = @(
        "oh-my-posh init pwsh --config 'C:\Program Files (x86)\oh-my-posh\themes\$THEME.omp.json' | Invoke-Expression",
        "Import-Module -Name Terminal-Icons",
        "Clear-Host"
    )
        
    Set-Content -Path $PROFILE -Value $profile_content
}

function Main {
    installRequirements
    setupTerminals
}

Main