#Requires -RunAsAdministrator

Write-Host Seting up your ssh connection to GitHub and the GitHub CLI

# Set up the ssh connection and the github CLI account

$email = Read-Host "Enter your email"

ssh-keygen -t ed25519 -C $email

$ssh_private_path = "$HOME\.ssh\id_ed25519"
$ssh_public_path = "$ssh_private_path.pub"
$computer_name = Read-Host "Enter the ssh key name (computer name)"

Set-Service -Name ssh-agent -StartupType Manual
Start-Service ssh-agent
Invoke-Expression ssh-add $ssh_private_path

Write-Host "Loggin into GitHub"

Invoke-Expression "gh auth login"

Write-Host "Adding ssh key"

Invoke-Expression "gh ssh-key add $ssh_public_path --title $computer_name"
