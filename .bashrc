alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias go='git checkout '
alias v='vim '
alias ls='ls --color=auto'

function cs() {
    cd "$@" && ls "-AlF"
}
