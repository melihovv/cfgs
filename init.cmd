@echo off

@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

REM Working directory
set wd=%~dp0

mklink "%HOME%.vimrc" "%wd%\.vimrc"

mklink "%HOME%.bashrc" "%wd%\.bashrc"
mklink "%HOME%.bash_aliases" "%wd%\.bash_aliases"
mklink "%HOME%.bash_functions" "%wd%\.bash_functions"

mklink "%HOME%.gitconfig" "%wd%\.gitconfig"
mklink "%HOME%.gitignore_global" "%wd%\.gitignore_global"
git config --global core.excludesfile "%HOME%.gitignore_global"

mklink "%HOME%.bash_profile" "%wd%\.bash_profile"
mklink "%HOME%.profile" "%wd%\.profile"

mklink /D "%HOME%vimfiles" "%wd%.vim\"

cd "%wd%"
git submodule init && git submodule update

