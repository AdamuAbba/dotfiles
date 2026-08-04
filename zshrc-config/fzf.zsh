export DISABLE_FZF_KEY_BINDINGS=true

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"

export FZF_DEFAULT_OPTS="
  --style=full
  --height=35%
  --ansi
  --no-scrollbar
  --list-border=rounded
  --info=hidden
  --margin=0,49%,0,0
  --preview-border=rounded
  --layout=reverse
  --pointer ''
  --marker ''
  --bind='result:transform-list-label:
    if [[ -z \$FZF_QUERY ]]; then
      echo \" \$FZF_MATCH_COUNT items \"
    else
      echo \" \$FZF_MATCH_COUNT matches for [\$FZF_QUERY] \"
    fi'
  --bind='focus:transform-preview-label:[[ -n {} ]] && printf \" [%s] \" {}'
  --color=border:${DRACULA_WHITE},label:${DRACULA_WHITE}
  --color=preview-border:${DRACULA_WHITE},preview-label:${DRACULA_WHITE}
  --color=input-border:${DRACULA_WHITE},input-label:${DRACULA_WHITE}
  --color=bg+:${DRACULA_GRAY},fg+:${DRACULA_WHITE},fg:${DRACULA_WHITE},prompt:${DRACULA_WHITE}
"

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
