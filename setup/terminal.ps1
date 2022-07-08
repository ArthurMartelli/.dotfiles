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
        $terminals
    )
    
    foreach ($terminal in $terminals) {
        New-Item -ItemType SymbolicLink -Path $terminal.path -Target $terminal.src -Force
    }
}

function setupProfile {
    param (
        [Parameter(Mandatory = $true)]
        $theme
    )
    # run 'Get-PoshThemes' in powershell to print the themes or look them at https://ohmyposh.dev/docs/themes/
    
    $profile_content = @(
        "oh-my-posh init pwsh --config 'C:\Program Files (x86)\oh-my-posh\themes\$theme.omp.json' | Invoke-Expression",
        "Import-Module -Name Terminal-Icons",
        "Clear-Host"
    )
        
    Set-Content -Path $PROFILE -Value $profile_content
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
        install = "Install-Module -Name Terminal-Icons -Repository PSGallery"
    }
)

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

$profile_theme = 'nordtron'


function Main {
    Write-Host $message


    installRequirements $programs
    setupTerminals $terminals
    setupProfile $profile_theme
}

Main