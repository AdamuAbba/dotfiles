#============ brew completions ====================
if type brew &>/dev/null; then
  fpath=($(brew --prefix)/share/zsh-completions $fpath)
fi

#============ custom completions ====================
if type uv &>/dev/null; then
  fpath=($HOME/Documents/dotfiles/zshrc-config/completions $fpath)
fi

#============ init completions safely ====================
if ! typeset -f compinit >/dev/null; then
  autoload -Uz compinit
fi
if [[ -z $ZSH_COMPDUMP ]]; then
  compinit -u
fi
