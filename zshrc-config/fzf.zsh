# export DISABLE_FZF_KEY_BINDINGS=true
FZF_ALT_C_COMMAND=
FZF_CTRL_T_COMMAND=

source <(fzf --zsh)

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"

export FZF_DEFAULT_OPTS_FILE="$HOME/.config/fzf/fzfrc"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

fif() {
  local file
  file="$(rga --ignore-case --files-with-matches --no-messages "$*" |
    fzf --preview="rga --ignore-case --pretty --context 10 '$*' {}")"

  if [ -n "$file" ]; then
    echo "opening $file"
    nvim "$file"
  else
    return 1
  fi
}
