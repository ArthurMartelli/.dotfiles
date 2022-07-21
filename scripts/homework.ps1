$DIR = "$HOME/github/homework"

Set-Location $DIR
Invoke-Expression "gh repo sync"
Invoke-Expression "python $DIR"

Set-Location $HOME