alias v="vim"
alias c="clear"
alias q="exit"
alias g="git"

if [ `uname` == "Linux" ]; then
    alias ls="ls --color=auto --group-directories-first"
    alias ll="ls -AlF --group-directories-first"
else
    alias ls="ls --color=auto"
    alias ll="ls -AlF"
fi

alias ..="cd .."
alias ...="cd ../.."

alias tmux="TERM=screen-256color tmux"
alias clipboard="xclip -sel clip"
alias open="gnome-open"

