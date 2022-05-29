# Update powershell

Invoke-Expression "& { $(Invoke-RestMethod 'https://aka.ms/install-powershell.ps1' ) } -UseMSI -Preview"

# Configure Windows Terminal

## Font installation

choco install cascadia-code-nerd-font
choco install cascadiacode
choco install cascadiamono
choco install cascadiacodepl
choco install cascadiamonopl

## Set default profile to newly-updated Powershell

## Change wt config
### font:
#### "face": "CascadiaCode Nerd Font",
### Opacity: 80

## Change code integrated terminal font to a nerd font

### add "terminal.integrated.fontFamily": "CascadiaCode Nerd Font",

# Oh-My-Posh installation

winget install oh-my-posh

$THEME = 'atomicBit'

echo "oh-my-posh init pwsh --config ~\AppData\Local\Programs\oh-my-posh\themes\$THEME.omp.json | Invoke-Expression" > $PROFILE

. $PROFILE

# Terminal icons

Set-Location C:\\

Install-Module -Name Terminal-Icons -Repository PSGallery
Import-Module -Name Terminal-Icons

Get-Item ./README.md

Get-ChildItem

Get-ChildItem | Format-List

Get-ChildItem | Format-Wide

Set-Location $HOME