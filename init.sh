#!/bin/bash

SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)/`basename "${BASH_SOURCE[0]}"`
SCRIPT_DIR="`dirname "${SCRIPT_PATH}"`"

BACKUP=$SCRIPT_DIR/backup
mkdir -p $BACKUP

backupAndLink() {
    if [ -f "$HOME/$1" ];
    then
        mv -f "$HOME/$1" "$BACKUP/"
    fi
    ln -s "$SCRIPT_DIR/$1" "$HOME/$1"
}

backupAndLinkDir() {
    if [ -d "$HOME/$1" ];
    then
        mv -f "$HOME/$1" "$BACKUP/"
    fi
    ln -s "$SCRIPT_DIR/$1" "$HOME/$1"
}

backupAndLink .bashrc
backupAndLink .bash_aliases
backupAndLink .bash_functions
backupAndLink .bash_profile

backupAndLink .zshrc

BABUN_THEME="$HOME/.oh-my-zsh/custom/babun.zsh-theme"
if [ ! -f $BABUN_THEME ];
then
    curl https://raw.githubusercontent.com/babun/babun/master/babun-core/plugins/oh-my-zsh/src/babun.zsh-theme > $BABUN_THEME
fi

backupAndLink .inputrc

backupAndLink .gitconfig
backupAndLink .gitignore_global

backupAndLinkDir .vim

backupAndLink .vimrc

cd "${SCRIPT_DIR}"
git submodule init && git submodule update

