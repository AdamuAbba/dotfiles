#============================================= ENV configs =============================================
export XDG_CONFIG_HOME="$HOME/.config"
export GITSTATUS_LOG_LEVEL=DEBUG
export GDK_SCALE=2
export HYPHEN_INSENSITIVE="true"
export COMPLETION_WAITING_DOTS="true"
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export VISUAL=nvim
export EDITOR="$VISUAL"
export DISABLE_AUTO_TITLE="true"

#============================================= Command History =============================================
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
HISTFILE=$HOME/.zsh_history
HISTSIZE=500
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
setopt appendhistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
unsetopt correct_all
unsetopt correct

# Disable Ctrl+Z
stty susp undef
bindkey -r '^Z'

export PATH="/opt/homebrew/opt/trash/bin:$PATH"
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#============================================= vim-mode selection highlights =============================================
BG=$(hex_to_256 "$DRACULA_SELECTION")
FG=$(hex_to_256 "$DRACULA_WHITE")

zle_highlight=(region:bg=$BG,fg=$FG)
