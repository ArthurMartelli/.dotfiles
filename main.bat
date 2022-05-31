@echo OFF

IF %ERRORLEVEL% EQU 0 (
    echo Beginning Choco installations
) ELSE (
    echo -------------------------------------------------------------
    echo ERROR: YOU ARE NOT RUNNING THIS WITH ADMINISTRATOR PRIVILEGES.
    echo -------------------------------------------------------------
    EXIT /B 1

)

winget install chocolatey
choco feature enable -n=allowGlobalConfirmation

ECHO Chocolatey is ready to begin installing packages!

cd %USERPROFILE%

CALL refreshenv
choco install git

CALL refreshenv
git clone https://github.com/ArthurMartelli/.dotfiles %USERPROFILE%\.dotfiles

FOR /F %%i IN ('dir /b /s "%USERPROFILE%\.dotfiles\scripts\ps1\*.ps1"') DO (
    pause
    CALL powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass %%i
    CALL refreshenv
)

:: CONFIGURE SOME PROGRAMS

echo Configuring some programs (login)

bw login
gh auth login

:: MAKE SYBMBOLIK LINKS FOR FILES

CALL py "%USERPROFILE%\.dotfiles\scripts\setup.py"