@echo off

@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

REM Working directory
set WD=%~dp0

set BACKUP="%WD%backup"
if not exist "%BACKUP%" (
    mkdir %BACKUP%
)


echo Linking dotfiles

call:backupAndLink .bashrc
call:backupAndLink .bash_aliases
call:backupAndLink .bash_functions
call:backupAndLink .bash_profile

call:backupAndLink .zshrc

call:backupAndLink .inputrc

call:backupAndLink .gitconfig
call:backupAndLink .gitignore_global


echo Linking vim
call:backupAndLink .vimrc
call:backupAndLinkDir "%HOME%\vimfiles" "%BACKUP%\vimfiles" "%WD%.vim"

cd "%WD%"
git submodule init && git submodule update


echo Linking emacs
set EMACS_DIR="%HOME%\.emacs.d"

if not exist %EMACS_DIR% (
	mkdir %EMACS_DIR%
)

call:backupAndLink init.el "%HOME%\.emacs.d" "%WD%emacs\"
call:backupAndLink Cask "%HOME%\.emacs.d" "%WD%emacs\"
call:backupAndLinkDir "%HOME%\.emacs.d\snippets" "%WD%backup\snippets" "%WD%emacs\snippets"

echo Calling cask to install emacs packages
cd /D "%HOME%\.emacs.d"
cask

goto:eof


REM Helpers

:backupAndLink
	set CUR_DIR="%~2"

	if "%~2"=="" (
		set CUR_DIR="%HOME%"
	)

    if exist "%CUR_DIR%\%~1" (
        move /Y "%CUR_DIR%\%~1" "%BACKUP%"
    )

	if "%~2"=="" (
        mklink "%CUR_DIR%\%~1" "%WD%%~1"
	) else (
        mklink "%CUR_DIR%\%~1" "%~3%~1"
    )
goto:eof

:backupAndLinkDir
    if exist "%~1" (
        xcopy "%~1" "%~2" /E /H /R /X /Y /I /K /b
        rm -r "%~1"
    )

    mklink /D "%~1" "%~3"
goto:eof
