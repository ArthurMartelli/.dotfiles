# Set up the dotfiles and install programs

Automatically setup some programs in your pc

run the following command in an admin powershell:

```powershell
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/ArthurMartelli/.dotfiles/main/main.ps1'))"
```
