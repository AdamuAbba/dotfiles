#============================================= ENV configs =============================================

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

#============================================= Command History =============================================
HISTFILE=$HOME/.zhistory
HISTSIZE=500
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
unsetopt correct_all
unsetopt correct

#============================================= Man stuff =============================================
export MANPATH="/usr/local/man:$MANPATH"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
MANROFFOPT="-c"
