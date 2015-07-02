@echo off

@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

mklink "%HOME%.vimrc" "%cd%\.vimrc"

mklink "%HOME%.bashrc" "%cd%\.bashrc"
mklink "%HOME%.bash_aliases" "%cd%\.bash_aliases"

mklink "%HOME%.gitconfig" "%cd%\.gitconfig"
mklink "%HOME%.gitignore_global" "%cd%\.gitignore_global"
git config --global core.excludesfile ~/.gitignore_global

mklink /D "%HOME%vimfiles" "%cd%\.vim\"

git submodule init && git submodule update

mklink /D "%HOME%vimfiles\autoload" "%cd%\.vim\bundle\vim-pathogen\autoload"

