#!/usr/bin/env bash

source $HOME/.autolaunch_tmux

[ -f $HOME/.fzf.bash ] && source $HOME/.fzf.bash

# Path to the bash it configuration
export BASH_IT="$HOME/.bash_it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='bobby'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Don't display vcs info.
export SCM_CHECK=false

# Load Bash It
source $BASH_IT/bash_it.sh

export EDITOR=vim
export PATH=~/.local/bin:$PATH

eval "$(fasd --init auto)"
alias v="f -e $EDITOR"

eval $(thefuck --alias)

[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

[ -f "$HOME/.extra" ] && source "$HOME/.extra"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
