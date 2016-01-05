#!/bin/bash

SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)/`basename \
	"${BASH_SOURCE[0]}"`
SCRIPT_DIR="`dirname "${SCRIPT_PATH}"`"

RED="\033[0;31m"
GREEN="\033[0;32m"
# No color.
NC="\033[0m"

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


colorEcho "Linking .my_aliases"
backupAndLink "$SCRIPT_DIR/shells/.my_aliases" "$HOME/.my_aliases"

if [ ! -d "$HOME/.bash_it" ];
then
    colorEcho "Installing bash-it"
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
    source  ~/.bash_it/install.sh
    backupAndLink "$SCRIPT_DIR/shells/.my_aliases" \
        "$HOME/.bash_it/aliases/custom.aliases.bash"
fi


if [ `which zsh` == "" ];
then
    colorEcho "Installing zsh"
    sudo apt-get install zsh
fi

if [ ! -d "$HOME/.oh-my-zsh" ];
then
    colorEcho "Download oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/\
        tools/install.sh)"
fi

colorEcho "Linking .zshrc"
backupAndLink "$SCRIPT_DIR/shells/zsh/.zshrc" "$HOME/.zshrc"

BABUN_THEME="$HOME/.oh-my-zsh/custom/babun.zsh-theme"
if [ ! -f $BABUN_THEME ];
then
    colorEcho "Download babun oh-my-zsh theme"
    curl "https://raw.githubusercontent.com/babun/babun/master/babun-core/\
        plugins/oh-my-zsh/src/babun.zsh-theme" > $BABUN_THEME
fi


colorEcho "Linking .tmux.conf"
backupAndLink "$SCRIPT_DIR/.tmux.conf" "$HOME/.tmux.conf"

colorEcho "Linking .git*"
backupAndLink "$SCRIPT_DIR/git/.gitconfig" "$HOME/.gitconfig"
backupAndLink "$SCRIPT_DIR/git/.gitignore_global" "$HOME/.gitignore_global"


colorEcho "Linking vim"
backupAndLink "$SCRIPT_DIR/editors/Vim/.vimrc" "$HOME/.vimrc"
backupAndLink "$SCRIPT_DIR/editors/Vim/.vim" "$HOME/.vim"

colorEcho "Installing vim plugins"
cd "${SCRIPT_DIR}"
git submodule init && git submodule update

