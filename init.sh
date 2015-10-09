#!/bin/bash

SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)/`basename "${BASH_SOURCE[0]}"`
SCRIPT_DIR="`dirname "${SCRIPT_PATH}"`"

BACKUP_DIR=$SCRIPT_DIR/backup
if [ ! -d "$BACKUP_DIR" ]; then
    echo "${RED} Making backup dir $BACKUP_DIR ${NC}"
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
GREEN='\033[0;32m'
NC='\033[0m'
myEcho() {
    printf "${GREEN}$1${NC}\n"
}


myEcho "Linking dotfiles"

myEcho "Linking .bash*"
backupAndLink "$SCRIPT_DIR/shells/bash/.bashrc" "$HOME/.bashrc"
backupAndLink "$SCRIPT_DIR/shells/bash/.bash_aliases" "$HOME/.bash_aliases"
backupAndLink "$SCRIPT_DIR/shells/bash/.bash_functions" "$HOME/.bash_functions"
backupAndLink "$SCRIPT_DIR/shells/bash/.bash_profile" "$HOME/.bash_profile"


myEcho "Installing zsh"
sudo apt-get install zsh

if [ ! -d "$HOME/.oh-my-zsh" ];
then
    myEcho "Download oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

myEcho "Linking .zshrc"
backupAndLink "$SCRIPT_DIR/shells/zsh/.zshrc" "$HOME/.zshrc"

BABUN_THEME="$HOME/.oh-my-zsh/custom/babun.zsh-theme"
if [ ! -f $BABUN_THEME ];
then
    myEcho "Download babun oh-my-zsh theme"
    curl https://raw.githubusercontent.com/babun/babun/master/babun-core/plugins/oh-my-zsh/src/babun.zsh-theme > $BABUN_THEME
fi


myEcho "Linking .inputrc"
backupAndLink "$SCRIPT_DIR/.inputrc" "$HOME/.inputrc"

myEcho "Linking .tmux.conf"
backupAndLink "$SCRIPT_DIR/.tmux.conf" "$HOME/.tmux.conf"

myEcho "Linking .git*"
backupAndLink "$SCRIPT_DIR/git/.gitconfig" "$HOME/.gitconfig"
backupAndLink "$SCRIPT_DIR/git/.gitignore_global" "$HOME/.gitignore_global"


myEcho "Linking emacs"
EMACS_DIR=$HOME/.emacs.d

if [ ! -d "$EMACS_DIR" ]; then
    myEcho "Making emacs dir $EMACS_DIR"
    mkdir "$EMACS_DIR"
fi

backupAndLink "$SCRIPT_DIR/editors/Emacs/init.el" "$HOME/.emacs.d/init.el"
backupAndLink "$SCRIPT_DIR/editors/Emacs/Cask" "$HOME/.emacs.d/Cask"
backupAndLink "$SCRIPT_DIR/editors/Emacs/snippets" "$HOME/.emacs.d/snippets"


myEcho "Linking vim"
backupAndLink "$SCRIPT_DIR/editors/Vim/.vimrc" "$HOME/.vimrc"
backupAndLink "$SCRIPT_DIR/editors/Vim/.vim" "$HOME/.vim"

myEcho "Installing vim plugins"
cd "${SCRIPT_DIR}"
git submodule init && git submodule update

#myEcho "Calling cask to install emacs packages"
#cd "$HOME/.emacs.d"
#cask

