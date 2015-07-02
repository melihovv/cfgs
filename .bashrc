function cs() {
    cd "$@" && ls "-AlF"
}

if [ -f $HOME/.bash_aliases ];
then
    . $HOME/.bash_aliases
fi

