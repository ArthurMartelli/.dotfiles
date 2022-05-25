@echo OFF

NET SESSION >nul 2>&1

IF %ERRORLEVEL% EQU 0 (

    echo Beginning Choco installations

) ELSE (

    echo -------------------------------------------------------------

    echo ERROR: YOU ARE NOT RUNNING THIS WITH ADMINISTRATOR PRIVILEGES.

    echo -------------------------------------------------------------

    EXIT /B 1

)

powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
choco feature enable -n=allowGlobalConfirmation

echo Chocolatey is ready to begin installing packages!

pause

@REM ----[ Whatever you want to install, place it below this point, each item on its own line (to make it easier to find later on. ] ----

call RefreshEnv.cmd

@REM PROGRAMMING LANGUAGES

choco install git
choco install gh
choco install python
choco install nodejs
choco install rust
choco install marp-cli
choco install rust
choco install rustup.install
choco install vim
choco install wsl2
choco install wsl-ubuntu-2004
choco install docker
choco install docker-desktop
choco install docker-machine
choco install sass
choco install autohotkey

pause

@REM PROGRAMS

choco install googlechrome
choco install vscode.install
choco install steam-client
choco install epicgameslauncher
choco install gimp
choco install zotero
choco install 7zip
choco install unrar
choco install microsoft-office-deployment

pause

@REM UPGRADES ALL PACKAGES

call RefreshEnv.cmd
choco upgrade all

@REM PIP INSTALLATIONS

pause

pip install pdfcli

@REM MAKE SYBMBOLIK LINKS FOR FILES

pause

gh auth login
gh repo clone ArthurMartelli/.dotfiles

py ".dotfiles\setup.py"