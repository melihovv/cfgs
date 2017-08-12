source $HOME/.autolaunch_tmux

source $HOME/antigen/antigen.zsh

export EDITOR=vim
export PATH=~/.local/bin:$PATH
setopt HIST_IGNORE_ALL_DUPS

antigen use oh-my-zsh
antigen bundle git
antigen bundle docker
antigen bundle docker-compose
antigen bundle extract
antigen bundle fasd
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen theme robbyrussell
antigen bundle lukechilds/zsh-nvm

antigen apply

# zsh-autosuggestions bindings.
bindkey '^ ' autosuggest-accept

# zsh-history-substring-search bindings.
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# globalias bindings.
globalias() {
   zle _expand_alias
   zle expand-word
}
# C-j for expand alias.
zle -N globalias
bindkey -M emacs "^j" globalias
bindkey -M viins "^j" globalias

autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^Xf" copy-earlier-word

eval $(thefuck --alias)

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

[ -f "$HOME/.extra" ] && source "$HOME/.extra"

