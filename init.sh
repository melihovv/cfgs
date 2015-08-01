#!/bin/bash

SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)/`basename "${BASH_SOURCE[0]}"`
SCRIPT_DIR="`dirname "${SCRIPT_PATH}"`"

BACKUP_DIR=$SCRIPT_DIR/backup
if [ ! -d "$BACKUP_DIR" ]; then
    echo Making backup dir $BACKUP_DIR
    mkdir -p $BACKUP_DIR
fi


# If destination exists backup it, then link destination to source.
# \param Source path.
# \param Destination path.
backupAndLink() {
    if [ -f "$2" ] || [ -d "$2" ]; then
        mv -f "$2" "$BACKUP_DIR"
    fi

    ln -s "$1" "$2"
}


echo Linking dotfiles

echo Linking .bash*
backupAndLink "$SCRIPT_DIR/.bashrc" "$HOME/.bashrc"
backupAndLink "$SCRIPT_DIR/.bash_aliases" "$HOME/.bash_aliases"
backupAndLink "$SCRIPT_DIR/.bash_functions" "$HOME/.bash_functions"
backupAndLink "$SCRIPT_DIR/.bash_profile" "$HOME/.bash_profile"

echo Linking .zshrc
backupAndLink "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"

BABUN_THEME="$HOME/.oh-my-zsh/custom/babun.zsh-theme"
if [ ! -f $BABUN_THEME ];
then
    echo Download babun oh-my-zsh theme
    curl https://raw.githubusercontent.com/babun/babun/master/babun-core/plugins/oh-my-zsh/src/babun.zsh-theme > $BABUN_THEME
fi

echo Linking .inputrc
backupAndLink "$SCRIPT_DIR/.inputrc" "$HOME/.inputrc"

echo Linking .git*
backupAndLink "$SCRIPT_DIR/.gitconfig" "$HOME/.gitconfig"
backupAndLink "$SCRIPT_DIR/.gitignore_global" "$HOME/.gitignore_global"


echo Linking emacs
EMACS_DIR=$HOME/.emacs.d

if [ ! -d "$EMACS_DIR" ]; then
    echo Making emacs dir %EMACS_DIR%
    mkdir "$EMACS_DIR"
fi

backupAndLink "$SCRIPT_DIR/emacs/init.el" "$HOME/.emacs.d/init.el"
backupAndLink "$SCRIPT_DIR/emacs/Cask" "$HOME/.emacs.d/Cask"
backupAndLink "$SCRIPT_DIR/emacs/snippets" "$HOME/.emacs.d/snippets"


echo Linking vim
backupAndLink "$SCRIPT_DIR/.vimrc" "$HOME/.vimrc"
backupAndLink "$SCRIPT_DIR/.vim" "$HOME/.vim"

echo Installing vim plugins
cd "${SCRIPT_DIR}"
git submodule init && git submodule update

# Cask is calling last because it creates new process.
echo Calling cask to install emacs packages
cd "$HOME/.emacs.d"
cask

