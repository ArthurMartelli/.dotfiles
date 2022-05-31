@echo OFF

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

CALL refreshenv
git clone https://github.com/ArthurMartelli/.dotfiles %USERPROFILE%\.dotfiles

:: Run all scripts in .\scripts\*.ps1

FOR /F %%i IN ('dir /b /s "%USERPROFILE%\.dotfiles\scripts\*.ps1"') DO (
    echo %%i
    @REM pause
    @REM CALL powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass %%i
    @REM CALL refreshenv
)

:: CONFIGURE SOME PROGRAMS

ECHO Configuring some programs (login)

bw login
gh auth login

:: MAKE SYBMBOLIK LINKS FOR FILES

CALL py "%USERPROFILE%\.dotfiles\scripts\setup.py"