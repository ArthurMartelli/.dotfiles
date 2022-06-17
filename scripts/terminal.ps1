#Requires -RunAsAdministrator

Write-Host "Setting up the terminal"

# Configure Windows Terminal

## Font installation

choco install cascadia-code-nerd-font
choco install cascadiacode
choco install cascadiamono
choco install cascadiacodepl
choco install cascadiamonopl

<#

Set default profile to Powershell

Change Windows Terminal config file

    font {
        "face": "CaskaydiaCove Nerd Font", (or the nerd font of preference)
    }

Change VSCode integrated terminal font to a nerd font (in JSON config file) by adding:

    "editor.fontFamily": "\"Cascadia Code\", Consolas, 'Courier New', monospace",
    "terminal.integrated.fontFamily": "CaskaydiaCove Nerd Fonts",


#>

Write-Output "Configure VScode and Windows Terminal"

pause

# Oh-My-Posh and terminal icons installation

choco install oh-my-posh
Install-Module -Name Terminal-Icons -Repository PSGallery

# select oh-my-posh theme

$THEME = 'nordtron'   # run 'Get-PoshThemes' in powershell to print the themes or look them at https://ohmyposh.dev/docs/themes/

# Setup $PROFILE

Write-Output @"
oh-my-posh init pwsh --config ~\AppData\Local\Programs\oh-my-posh\themes\$THEME.omp.json | Invoke-Expression
Import-Module -Name Terminal-Icons
Clear-Host
"@ > $PROFILE

. $PROFILE
