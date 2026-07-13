#============ brew completions ====================
if type brew &>/dev/null; then
  fpath=($(brew --prefix)/share/zsh-completions $fpath)
fi

#============ custom completions ====================
tools=(uv)
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

if command -v uv >/dev/null 2>&1; then
  # enable shell autocompletion for uv
  eval "$(uv generate-shell-completion zsh)"
  eval "$(uvx --generate-shell-completion zsh)"
else
  echo "Error: uv is not installed. Skipping uv completions."
fi

#============ init completions safely ====================
if ! typeset -f compinit >/dev/null; then
  autoload -Uz compinit
fi
if [[ -z $ZSH_COMPDUMP ]]; then
  compinit -u
fi
