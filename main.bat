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

ECHO Chocolatey is ready to begin installing packages!

cd %USERPROFILE%

CALL refreshenv
choco install git

call refreshenv
git clone https://github.com/ArthurMartelli/.dotfiles %USERPROFILE%\.dotfiles

:: MAKE SYBMBOLIK LINKS FOR FILES

py "%USERPROFILE%\.dotfiles\scripts\setup.py"

FOR /F %i IN ('dir /b /s "%USERPROFILE%\.dotfiles\scripts\ps1\*.ps1"') DO (
    pause
    powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass %i
    call refreshenv
)

:: CONFIGURE SOME PROGRAMS

echo Configuring some programs (login)

bw login
gh auth login
