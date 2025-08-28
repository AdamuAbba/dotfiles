#============================================= ENV configs =============================================
export HELIX_RUNTIME=/opt/homebrew/Cellar/helix/25.01.1/libexec/runtime
export XDG_CONFIG_HOME="$HOME/.config"
export SCREEN_RECORDING_DIR="$HOME/Movies/screen-recordings"
GITSTATUS_LOG_LEVEL=DEBUG
export PATH="$HOME/bin:$PATH"
export GDK_SCALE=2
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=$HOME/dotfiles/.config/rofi/scripts:$PATH
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export VISUAL=nvim
export EDITOR="$VISUAL"
export LAZYPLUGINS="$HOME/.local/share/nvim/site/pack/lazy/start"

#============================================= Hooks =============================================
autoload -U add-zsh-hook

update_workspace_mode() {
  export WORKSPACE_MODE="$(cat ~/.workspace_mode 2>/dev/null || echo laptop)"
}

add-zsh-hook precmd update_workspace_mode
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
