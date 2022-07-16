#Requires -RunAsAdministrator

$message = "Setting up custom terminal"

function installRequirements {
    param (
        [Parameter(Mandatory = $true)]
        $Requirements
    )
    
    foreach ($item in $Requirements) {
        Write-Host "Installing $($item.name)"
        Invoke-Expression $item.install
    }
}

function setupTerminals {
    param (
        [Parameter(Mandatory = $true)]
        $terminals,
        [Parameter(Mandatory = $true)]
        $theme
        # run 'Get-PoshThemes' in powershell to print the themes or look them at https://ohmyposh.dev/docs/themes/
    )
    
    $profile_path = "$HOME/.profile"

    foreach ($terminal in $terminals) {
        New-Item -ItemType SymbolicLink -Path $($terminal.path) -Target $($terminal.src) -Force
        New-Item -ItemType SymbolicLink -Path $($terminal.profile) -Target $profile_path -Force
        echo "New-Item -ItemType SymbolicLink -Path $($terminal.profile) -Target $profile_path -Force"
    }
}

$programs = @(
    @{
        name    = "Cascadia Code Nerd Font"
        install = "choco install cascadia-code-nerd-font"
    },
    @{
        name    = "Cascadia Code"
        install = "choco install cascadiacode"
    },
    @{
        name    = "Cascadia Mono"
        install = "choco install cascadiamono"
    },
    @{
        name    = "Cascadia Code PL"
        install = "choco install cascadiacodepl"
    },
    @{
        name    = "Cascadia Mono PL"
        install = "choco install cascadiamonopl"
    },
    @{
        name    = "Oh My Posh"
        install = "choco install oh-my-posh"
    },
    @{
        name    = "Terminal icons"
        install = "Install-Module -Name Terminal-Icons -Repository PSGallery -Force"
    }
)

$terminals = @(
    @{
        name    = "wt"
        path    = "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
        profile = "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
        src     = "$HOME\.wtconfig"
    },
    @{
        name    = "vscode"
        path    = "$HOME\AppData\Roaming\Code\User\settings.json"
        profile = "$HOME\Documents\WindowsPowerShell\Microsoft.VSCode_profile.ps1"
        src     = "$HOME\.vscodeconfig"
    }
)

function Main {
    Write-Host $message
    $profile_theme = 'nordtron'
    # installRequirements $programs
    setupTerminals $terminals $profile_theme
}

Main