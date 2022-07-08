#Requires -RunAsAdministrator

function createSymlink {
    param (
        [Parameter(Mandatory = $true)]
        $FILES
    )
    
    ForEach ($FILE in $FILES) {
        $LINK = "$HOME\$($FILE.name)"
        
        try {
            New-Item -ItemType SymbolicLink -Path $LINK -Target $FILE -Force
            $(Get-Item $LINK).Attributes += 'Hidden'
            Write-Output "[CREATED {$($FILE.name)}] {$FILE} -> {$LINK}"
        }
        catch {
            Write-Output "[SKIPPED {$($FILE.name)}] {$FILE} -> {$LINK}"
        }
        
    }
}

$DIR = "$HOME\.dotfiles"
$DOT_FILES = Get-ChildItem "$DIR\.files"
$DOT_DIRS = Get-ChildItem "$DIR\.dirs"

function Main {
    Write-Host "Creating SymLinks for config files"

    createSymlink $DOT_FILES
    createSymlink $DOT_DIRS
}

Main