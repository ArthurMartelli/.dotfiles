@echo OFF

cd %UserProfile%

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
choco install chocolatey
choco install chocolatey-compatibility.extension
choco install chocolatey-core.extension
choco install chocolatey-dotnetfx.extension
choco install chocolatey-misc-helpers.extension
choco install chocolatey-visualstudio.extension
choco install chocolatey-windowsupdate.extension
choco install dart-sdk

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
choco install virtualbox

pause

@REM UPGRADES ALL PACKAGES

call RefreshEnv.cmd
choco upgrade all

@REM PIP INSTALLATIONS

pause

pip install pdf-cli

@REM VS CODE EXTENSIONS INSTALLATIONS

@REM code --list-extensions

pause

call code --install-extension alexcvzz.vscode-sqlite
call code --install-extension batisteo.vscode-django
call code --install-extension chrmarti.regex
call code --install-extension DavidAnson.vscode-markdownlint
call code --install-extension donjayamanne.python-environment-manager
call code --install-extension donjayamanne.python-extension-pack
call code --install-extension eamodio.gitlens
call code --install-extension fnando.linter
call code --install-extension frhtylcn.pythonsnippets
call code --install-extension GitHub.github-vscode-theme
call code --install-extension KevinRose.vsc-python-indent
call code --install-extension marcbruederlin.mint-theme
call code --install-extension marp-team.marp-vscode
call code --install-extension mblode.zotero
call code --install-extension ms-azuretools.vscode-docker
call code --install-extension ms-python.python
call code --install-extension ms-python.vscode-pylance
call code --install-extension ms-vscode-remote.remote-containers
call code --install-extension njpwerner.autodocstring
call code --install-extension oderwat.indent-rainbow
call code --install-extension ritwickdey.LiveServer
call code --install-extension sasa.vscode-sass-format
call code --install-extension syler.sass-indented
call code --install-extension tomoki1207.pdf
call code --install-extension Tyriar.lorem-ipsum
call code --install-extension VisualStudioExptTeam.vscodeintellicode
call code --install-extension vscode-icons-team.vscode-icons
call code --install-extension wholroyd.jinja
call code --install-extension yzhang.markdown-all-in-one

@REM CONFIGURE SOME PROGRAMS

pause

bw login
gh auth login

@REM MAKE SYBMBOLIK LINKS FOR FILES

pause
gh repo clone ArthurMartelli/.dotfiles %userprofile%\.dotfiles

py ".dotfiles\setup.py"