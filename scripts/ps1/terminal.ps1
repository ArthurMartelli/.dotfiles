# Update powershell

Invoke-Expression "& { $(Invoke-RestMethod 'https://aka.ms/install-powershell.ps1' ) } -UseMSI -Preview"

# Configure Windows Terminal

## Font installation

choco install cascadia-code-nerd-font
choco install cascadiacode
choco install cascadiamono
choco install cascadiacodepl
choco install cascadiamonopl

<#

Set default profile to newly-updated Powershell

Change Windows Terminal config file

    font {
        "face": "CaskaydiaCove Nerd Font",
    }

and set 
    {...
        Opacity: 80
    }

Change VSCode integrated terminal font to a nerd font (in JSON config file) by adding:

    "editor.fontFamily": "\"Cascadia Code\", Consolas, 'Courier New', monospace",
    "terminal.integrated.fontFamily": "CaskaydiaCove Nerd Fonts",

    
#>
    
Write-Output "Configure VScode and Windows Terminal"

pause

# Oh-My-Posh installation

winget install oh-my-posh

$THEME = 'atomicBit'

# Setup $PROFILE

Write-Output @"
oh-my-posh init pwsh --config ~\AppData\Local\Programs\oh-my-posh\themes\$THEME.omp.json | Invoke-Expression
Clear-Host
"@ > $PROFILE

. $PROFILE
