#--------------------------------------- oh-my-zsh --------------------------------
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
#------------- zsh-fzf-history-search ---------------
ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0
ZSH_FZF_HISTORY_SEARCH_REMOVE_DUPLICATES=1
ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
#============================================= Base configs =============================================
zstyle ':omz:lib:directories' aliases no
zstyle ':omz:lib:*' aliases no

#============================================= Alias Finder =============================================
zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' longer no
zstyle ':omz:plugins:alias-finder' exact yes
zstyle ':omz:plugins:alias-finder' cheaper no

#============================================= zoxide =============================================
export ZOXIDE_CMD_OVERRIDE="cd"
