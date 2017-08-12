source $HOME/.autolaunch_tmux

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

source $HOME/.zplug/init.zsh

export EDITOR=vim
export PATH=~/.local/bin:$PATH
setopt HIST_IGNORE_ALL_DUPS

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/fasd", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "themes/robbyrussell", as:theme, from:oh-my-zsh
zplug "lukechilds/zsh-nvm"

if ! zplug check;
then
    zplug install
fi

zplug load

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

[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

[ -f "$HOME/.extra" ] && source "$HOME/.extra"

