if command -v tmux>/dev/null;
then
  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
fi

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

export NVM_LAZY_LOAD=true
antigen bundle lukechilds/zsh-nvm

antigen apply

setopt menucomplete
zstyle ':completion:*' menu select=1 _complete _ignored _approximate

bindkey '^ ' autosuggest-accept
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

[ -f "$HOME/.extra" ] && source "$HOME/.extra"

