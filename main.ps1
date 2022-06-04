#Requires -RunAsAdministrator

Set-Location $HOME

# Install chocolatey

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco feature enable -n = allowGlobalConfirmation

Write-Output Chocolatey is ready to begin installing packages!

# Refresh enviroment variable to install git with choco

Invoke-Expression refreshenv

choco install git

# Refreshes env and clones the repository for further installation

Invoke-Expression refreshenv

git clone "https://github.com/ArthurMartelli/.dotfiles" $HOME\.dotfiles

# Run all scripts in .\scripts\*.ps1

Get-ChildItem -Path "$HOME\.dotfiles\scripts\*.ps1" | Foreach-Object {
    pause "Press any key to continue"
    Write-Output $_.FullName
    Invoke-Expression refreshenv
}

# Configure some programs

Write-Output "Login into some programs"

Invoke-Expression bw login

# Make sybmbolik links for files

Write-Output "Creating Symbolic Link"

Invoke-Expression "py $HOME\.dotfiles\scripts\setup.py"
