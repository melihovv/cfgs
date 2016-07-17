#!/bin/bash

# Abort script on the first error.
set -e

SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)/`basename \
	"${BASH_SOURCE[0]}"`
SCRIPT_DIR="`dirname "${SCRIPT_PATH}"`"

RED="\033[0;31m"
GREEN="\033[0;32m"
# No color.
NC="\033[0m"

if [ ! $1 == "" ] && [ -d $1 ];
then
    DEST=$1
else
    DEST=$HOME
fi

BACKUP_DIR=$SCRIPT_DIR/backup
if [ ! -d "$BACKUP_DIR" ];
then
    echo -e "${RED} Making backup dir $BACKUP_DIR ${NC}"
    mkdir -p $BACKUP_DIR
fi


# If destination exists backup it, then link destination to source.
# \param Source path.
# \param Destination path.
backupAndLink() {
    if [ -L "$2" ] || [ -f "$2" ] || [ -d "$2" ]; then
        mv -f "$2" "$BACKUP_DIR"
    fi

    ln -s "$1" "$2"
}

# Color output.
colorEcho() {
    printf "${GREEN}$1${NC}\n"
}

provideBashIt() {
	if [ -d "$HOME/.bash_it" ];
	then
	    backupAndLink "$SCRIPT_DIR/shells/.bashrc" "$DEST/.bashrc"
	fi
}

provideZsh() {
	if [ "$(which zsh)" == "" ];
	then
	    colorEcho "Installing zsh"
	    sudo apt install -y zsh
	fi
}

provideOhMyZsh() {
    if [ ! -d "$DEST/.oh-my-zsh" ];
    then
        colorEcho "Download oh-my-zsh"
        sh -c "$(curl -fsSL http://raw.github.com/robbyrussell/oh-my-zsh/\
master/tools/install.sh)"
    fi

    if [ -d "$DEST/.oh-my-zsh" ];
    then
        colorEcho "Linking .zshrc"
        backupAndLink "$SCRIPT_DIR/shells/.zshrc" "$DEST/.zshrc"
    fi

    BABUN_THEME="$DEST/.oh-my-zsh/custom/babun.zsh-theme"
    if [ ! -f $BABUN_THEME ];
    then
        colorEcho "Download babun oh-my-zsh theme"
        curl "https://raw.githubusercontent.com/babun/babun/master/babun-core/\
plugins/oh-my-zsh/src/babun.zsh-theme" > $BABUN_THEME
    fi
}

provideShells() {
	provideBashIt
	provideZsh
	provideOhMyZsh
	colorEcho "Linking .my_aliases"
	backupAndLink "$SCRIPT_DIR/shells/.my_aliases" "$DEST/.my_aliases"
}

provideGit() {
    cd $SCRIPT_DIR
	colorEcho "Linking .git*"
	backupAndLink "$SCRIPT_DIR/git/.gitconfig" "$DEST/.gitconfig"
	backupAndLink "$SCRIPT_DIR/git/.gitignore_global" "$DEST/.gitignore_global"
}

provideVim() {
	colorEcho "Linking vim"
	backupAndLink "$SCRIPT_DIR/editors/vim/.vimrc" "$DEST/.vimrc"
	backupAndLink "$SCRIPT_DIR/editors/vim/.vim" "$DEST/.vim"

	colorEcho "Installing vim plugins"
	git submodule init && git submodule update
}

provideOthers() {
	colorEcho "Linking .tmux.conf"
	backupAndLink "$SCRIPT_DIR/.tmux.conf" "$DEST/.tmux.conf"
}


provideShells
provideGit
provideVim
provideOthers

