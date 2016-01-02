# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Use case-insensitive filename globbing
shopt -s nocaseglob

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well

# Some people use a different file for aliases
if [ -f "${HOME}/.my_aliases" ]; then
  source "${HOME}/.my_aliases"
fi

# Some people use a different file for functions
if [ -f "${HOME}/.bash_functions" ]; then
  source "${HOME}/.bash_functions"
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

if [ `uname | grep mingw64 -i` ]; then
    export TERM=cygwin
else
    [[ $TMUX = "" ]] && export TERM="xterm-256color"
fi

if [ `uname` == "Linux" ]; then
    export PATH="$HOME/.cask/bin:$PATH"
    source /etc/bash_completion.d/git-prompt
fi

export PS1="\[\033]0;$MSYSTEM:${PWD//[^[:ascii:]]/?}\007\]\n\[\033[32m\]\u@\h \
    \[\033[33m\]\w$(__git_ps1 "(%s)")\[\033[0m\]\n\\$ "

