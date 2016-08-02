# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Which plugins would you like to load? (plugins can be found in
# ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker docker-compose extract fasd)

setopt HIST_IGNORE_ALL_DUPS

# For arrows using when tab pressed for completion.
setopt menucomplete
zstyle ':completion:*' menu select=1 _complete _ignored _approximate

export PATH="$HOME/bin:/usr/local/bin:$PATH"
export LANG=en_US.UTF-8

source $ZSH/oh-my-zsh.sh

export EDITOR=vim

if [ -f "$HOME/.aliases" ];
then
  source "$HOME/.aliases"
fi

if [ -f "$HOME/.extra" ];
then
  source "$HOME/.extra"
fi

