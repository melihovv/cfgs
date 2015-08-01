@echo off
SetLocal EnableDelayedExpansion

@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

REM Directory, where script is located.
REM path\to\this\script\
set SCRIPT_DIR=%~dp0
REM path\to\this\script
set SCRIPT_DIR=%SCRIPT_DIR:~0,-1%

REM Make backup folder if it doesn't exist.
set BACKUP_DIR=%SCRIPT_DIR%\backup
if not exist "%BACKUP_DIR%" (
    echo Making backup dir "%BACKUP_DIR%"
    mkdir "%BACKUP_DIR%"
)


echo Linking dotfiles

echo Linking .bash*
call:backupAndLink "%SCRIPT_DIR%\.bashrc" "%HOME%\.bashrc"
call:backupAndLink "%SCRIPT_DIR%\.bash_aliases" "%HOME%\.bash_aliases"
call:backupAndLink "%SCRIPT_DIR%\.bash_functions" "%HOME%\.bash_functions"
call:backupAndLink "%SCRIPT_DIR%\.bash_profile" "%HOME%\.bash_profile"

echo Linking .zshrc
call:backupAndLink "%SCRIPT_DIR%\.zshrc" "%HOME%\.zshrc"

echo Linking .inputrc
call:backupAndLink "%SCRIPT_DIR%\.inputrc" "%HOME%\.inputrc"

echo Linking .git*
call:backupAndLink "%SCRIPT_DIR%\.gitconfig" "%HOME%\.gitconfig"
call:backupAndLink "%SCRIPT_DIR%\.gitignore_global" "%HOME%\.gitignore_global"


echo Linking emacs
set EMACS_DIR=%HOME%\.emacs.d

if not exist "%EMACS_DIR%" (
    echo Making emacs dir %EMACS_DIR%
	mkdir "%EMACS_DIR%"
)

call:backupAndLink "%SCRIPT_DIR%\emacs\init.el" "%HOME%\.emacs.d\init.el"
call:backupAndLink "%SCRIPT_DIR%\emacs\Cask" "%HOME%\.emacs.d\Cask"
call:backupAndLinkDir "%SCRIPT_DIR%\emacs\snippets" "%HOME%\.emacs.d\snippets"


echo Linking vim
call:backupAndLink "%SCRIPT_DIR%\.vimrc" "%HOME%\.vimrc"
call:backupAndLinkDir "%SCRIPT_DIR%\.vim" "%HOME%\vimfiles"

echo Installing vim plugins
cd "%WD%"
git submodule init && git submodule update


REM Cask is calling last because it creates new process.
echo Calling cask to install emacs packages
cd /D "%HOME%\.emacs.d"
cask

goto:eof


REM Helpers

REM Takes last folder name from path.
REM c:\1\2\3 45 => %LAST_DIR%==3 45.
REM Trailing backslash is disallowed.
REM \param Path.
REM \return Last folder name from path.
:takeLastFolderName
    for %%f in ("%~1") do (
        set LAST_DIR=%%~nxf
    )
goto:eof

REM If destination exists backup it, then link destination to source.
REM \param Source path.
REM \param Destination path.
:backupAndLinkDir
    if exist "%~2" (
        call:takeLastFolderName "%~2"
        REM /E - copy all subdirectories, even if they are empty.
        REM /H - copy files with hidden and system file attributes. By default, xcopy does not copy hidden or system files.
        REM /R - copy read-only files.
        REM /X - copy file audit settings and system access control list (SACL) information (implies /o).
        REM /Y - suppresses prompting to confirm that you want to overwrite an existing destination file.
        REM /I - if Source is a directory or contains wildcards and Destination does not exist, xcopy assumes destination specifies a directory name and creates a new directory. Then, xcopy copies all specified files into the new directory. By default, xcopy prompts you to specify whether Destination is a file or a directory.
        REM /K - copy files and retains the read-only attribute on destination files if present on the source files. By default, xcopy removes the read-only attribute.
        REM /B - copy symbolic link itself versus the target of the link.
        xcopy "%~2" "%BACKUP_DIR%\!LAST_DIR!" /E /H /R /X /Y /I /K /B
        
        REM -r - delete directory and its content recursively.
        rm -r "%~2"
    )

    REM /D - creates a directory symbolic link.
    mklink /D "%~2" "%~1"
goto:eof

REM If destination exists backup it, then link destination to source.
REM \param Source path.
REM \param Destination path.
:backupAndLink
    if exist "%~2" (
        REM /Y - suppress prompting to confirm you want to overwrite an existing file.
        move /Y "%~2" "%BACKUP_DIR%"
    )

    mklink "%~2" "%~1"
goto:eof
