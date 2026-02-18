#============ brew completions ====================
if type brew &>/dev/null; then
  fpath=($(brew --prefix)/share/zsh-completions $fpath)
fi

#============ custom completions ====================
tools=(uv mw)
missing=()

for tool in "${tools[@]}"; do
  if ! type "$tool" &>/dev/null; then
    missing+=("$tool")
    echo "Error: $tool is not installed."
  fi
done

if [[ ${#missing[@]} -eq 0 ]]; then
  fpath=($HOME/Documents/dotfiles/zshrc-config/completions $fpath)
fi

#============ init completions safely ====================
if ! typeset -f compinit >/dev/null; then
  autoload -Uz compinit
fi
if [[ -z $ZSH_COMPDUMP ]]; then
  compinit -u
fi
