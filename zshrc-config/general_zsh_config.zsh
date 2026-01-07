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

# autoload -Uz edit-command-line
# zle -N edit-command-line
# bindkey -M vicmd 'vv' edit-command-line

function tmux-edit-commandline-popup() {
  emulate -L zsh
  setopt localoptions no_aliases

  [[ -n "$TMUX" ]] || {
    zle -M "not in tmux"
    return 1
  }

  local tmp="${TMPDIR:-/tmp}/zsh_cmdline_${EPOCHREALTIME//[^0-9]/}.zsh"
  print -r -- "$BUFFER" >|"$tmp"

  tmux display-popup -E \
    -T "Edit Command Line" \
    -w 80% \
    -h 80% "sh -lc '${EDITOR:-nvim} $(printf %q "$tmp")'"

  # If editor exited successfully, load file back into the command line
  if [[ -r "$tmp" ]]; then
    BUFFER="$(<"$tmp")"
    CURSOR=${#BUFFER}
  fi

  rm -f -- "$tmp"
  zle redisplay
}

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
BG=$(hex_to_256 "$DRACULA_PURPLE")
FG=$(hex_to_256 "$DRACULA_BLACK")

zle_highlight=(region:bg=$BG,fg=$FG)
