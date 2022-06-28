# Set up the dotfiles and install programs

Automatically setup some programs in your pc

run the following command in an admin powershell:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/ArthurMartelli/.dotfiles/main/main.ps1'))
```
