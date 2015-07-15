@echo off

@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

REM Working directory
set WD=%~dp0

set BACKUP="%WD%backup\"
if not exist "%BACKUP%" (
    mkdir %BACKUP%
)

call:backupAndLink .bashrc
call:backupAndLink .bash_aliases
call:backupAndLink .bash_functions
call:backupAndLink .bash_profile

call:backupAndLink .zshrc

call:backupAndLink .inputrc

call:backupAndLink .profile

call:backupAndLink .gitconfig
call:backupAndLink .gitignore_global

call:backupAndLink .vimrc

if exist "%HOME%\vimfiles" (
    xcopy "%HOME%\vimfiles" "%BACKUP%\vimfiles" /E /H /R /X /Y /I /K /b
    rm -r "%HOME%\vimfiles"
)
mklink /D "%HOME%\vimfiles" "%WD%.vim\"

cd "%WD%"
git submodule init && git submodule update

goto:eof

:backupAndLink
    if exist "%HOME%\%~1" (
        move /Y "%HOME%\%~1" "%BACKUP%"
    )
    mklink "%HOME%\%~1" "%WD%%~1"
goto:eof

