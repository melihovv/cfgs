[ "$(uname -s)" = "Linux" ] && source $HOME/.autolaunch_tmux

source $HOME/antigen/antigen.zsh

export EDITOR=vim

[ "$(uname -s)" = "Darwin" ] && export PATH=$PATH:/usr/local/sbin

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

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

[ "$(uname -s)" = "Linux" ] && eval $(thefuck --alias)

export FZF_DEFAULT_OPTS='--reverse'

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

[ -f "$HOME/.extra" ] && source "$HOME/.extra"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ "$(uname -s)" = "Darwin" ] && [ -f "$HOME/.iterm2_shell_integration.zsh" ] && source ~/.iterm2_shell_integration.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
