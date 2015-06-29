alias gs='git status'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias go='git checkout'
alias v='vim'
alias c='clear'
alias ls='ls --color=auto'
alias ll='ls -AlF'

function cs() {
    cd "$@" && ls "-AlF"
}
