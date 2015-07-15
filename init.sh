#!/bin/bash

SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)/`basename "${BASH_SOURCE[0]}"`
SCRIPT_DIR="`dirname "${SCRIPT_PATH}"`"

ln -s "$SCRIPT_DIR/.bashrc" "$HOME/.bashrc"
ln -s "$SCRIPT_DIR/.bash_aliases" "$HOME/.bash_aliases"
ln -s "$SCRIPT_DIR/.bash_functions" "$HOME/.bash_functions"
ln -s "$SCRIPT_DIR/.bash_profile" "$HOME/.bash_profile"

ln -s "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"

ln -s "$SCRIPT_DIR/.profile" "$HOME/.profile"

ln -s "$SCRIPT_DIR/.inputrc" "$HOME/.inputrc"

ln -s "$SCRIPT_DIR/.gitconfig" "$HOME/.gitconfig"
ln -s "$SCRIPT_DIR/.gitignore_global" "$HOME/.gitignore_global"

if [ -h "$HOME/.vim" ];
then
    rm -rf "$HOME/.vim"
fi
ln -s "$SCRIPT_DIR/.vimrc" "$HOME/.vimrc"
ln -s "$SCRIPT_DIR/.vim" "$HOME/.vim"

cd "${SCRIPT_DIR}"
git submodule init && git submodule update
