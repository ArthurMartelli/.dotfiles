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
choco install rustup.install
choco install vim
choco install wsl2
choco install wsl-ubuntu-1804
choco install docker-cli
choco install docker-desktop
choco install sass
choco install autohotkey.portable

@REM COMMANDS AND CLI

choco install curl
choco install pandoc
choco install speedtest
choco install bitwarden-cli
choco install marp-cli
choco install grep

pause

@REM PROGRAMS

choco install microsoft-windows-terminal
choco install googlechrome
choco install opera-gx
choco install tor-browser
choco install vscode
choco install steam-client
choco install epicgameslauncher
choco install discord
choco install razer-synapse-3
choco install spotify
choco install obs-studio
choco install gimp
choco install zotero
choco install 7zip
choco install unrar
choco install microsoft-office-deployment
choco install microsoft-teams

pause

@REM UPGRADES ALL PACKAGES

call RefreshEnv.cmd
choco upgrade all

@REM PIP INSTALLATIONS

pause

pip install pdfcli

@REM VS CODE EXTENSIONS INSTALLATIONS

@REM code --list-extensions

code --install-extension alexcvzz.vscode-sqlite
code --install-extension batisteo.vscode-django
code --install-extension chrmarti.regex
code --install-extension DavidAnson.vscode-markdownlint
code --install-extension donjayamanne.python-environment-manager
code --install-extension donjayamanne.python-extension-pack
code --install-extension eamodio.gitlens
code --install-extension fnando.linter
code --install-extension frhtylcn.pythonsnippets
code --install-extension GitHub.github-vscode-theme
code --install-extension KevinRose.vsc-python-indent
code --install-extension marcbruederlin.mint-theme
code --install-extension marp-team.marp-vscode
code --install-extension mblode.zotero
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-vscode-remote.remote-containers
code --install-extension njpwerner.autodocstring
code --install-extension oderwat.indent-rainbow
code --install-extension ritwickdey.LiveServer
code --install-extension sasa.vscode-sass-format
code --install-extension syler.sass-indented
code --install-extension tomoki1207.pdf
code --install-extension Tyriar.lorem-ipsum
code --install-extension VisualStudioExptTeam.vscodeintellicode
code --install-extension vscode-icons-team.vscode-icons
code --install-extension wholroyd.jinja
code --install-extension yzhang.markdown-all-in-one

@REM CONFIGURE SOME PROGRAMS

pause

bw login
gh auth login

@REM MAKE SYBMBOLIK LINKS FOR FILES

pause
gh repo clone ArthurMartelli/.dotfiles %userprofile%\.dotfiles

py ".dotfiles\setup.py"