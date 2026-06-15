#!/usr/bin/env bash

export BASH_SILENCE_DEPRECATION_WARNING=1

#source $HOME/.autolaunch_tmux

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

#eval $(thefuck --alias)

[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

[ -f "$HOME/.extra" ] && source "$HOME/.extra"

# fzf after bash-it (bash-preexec loads inside bash-it)
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# fzf C-r: bash-it can clobber bindings on each prompt; re-apply after bash-it loads.
# __fzf_history__ echoes to stdout only when READLINE_POINT is unset (macro/subshell
# path). bind -x on bash >= 4 calls it directly so READLINE_LINE is set in place.
if declare -F __fzf_history__ > /dev/null; then
  __fzf_history_macro__() {
    unset READLINE_POINT
    __fzf_history__
  }
  _fzf_bind_ctrl_r() {
    if ((BASH_VERSINFO[0] >= 4)); then
      bind -m emacs-standard -x '"\C-r": __fzf_history__' 2>/dev/null
      bind -m vi-command -x '"\C-r": __fzf_history__' 2>/dev/null
      bind -m vi-insert -x '"\C-r": __fzf_history__' 2>/dev/null
    else
      bind -m emacs-standard '"\C-r": "\C-e \C-u\C-y\ey\C-u`__fzf_history_macro__`\e\C-e\C-\e("'
      bind -m vi-command '"\C-r": "\C-z\C-r\C-z"'
      bind -m vi-insert '"\C-r": "\C-z\C-r\C-z"'
    fi
  }
  _fzf_bind_ctrl_r
  if [[ " ${precmd_functions[*]:-} " != *" _fzf_bind_ctrl_r "* ]]; then
    precmd_functions+=(_fzf_bind_ctrl_r)
  fi
fi
