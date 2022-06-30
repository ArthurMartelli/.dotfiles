oh-my-posh init pwsh --config 'C:\Program Files (x86)\oh-my-posh\themes\nordtron.omp.json' | Invoke-Expression

Import-Module -Name Terminal-Icons

$env:path += ";$HOME\.dotfiles\scripts"

Clear-Host