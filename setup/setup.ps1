#Requires -RunAsAdministrator

function createSymlink {
    param (
        [Parameter(Mandatory = $true)]
        $FILES
    )
    
    ForEach ($FILE in $FILES) {
        $LINK = "$HOME\$($FILE.name)"

        try {
            New-Item -ItemType SymbolicLink -Path $LINK -Target $FILE.fullname -Force
            $(Get-Item $LINK).Attributes += 'Hidden'
            Write-Output "[CREATED {$($FILE.name)}] {$($FILE.fullname)} -> {$LINK}"
        }
        catch {
            Write-Output "[SKIPPED {$($FILE.name)}] {$($FILE.fullname)} -> {$LINK}"
        }
        
    }
}

$DIR = "$HOME\.dotfiles"
$DOT_FILES = Get-ChildItem "$DIR\.files"

function Main {
    Write-Host "Creating SymLinks for config files"

    createSymlink $DOT_FILES
}

Main