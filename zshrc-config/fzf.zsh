export DISABLE_FZF_KEY_BINDINGS=true

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"

export FZF_DEFAULT_OPTS="
  --style=full
  --height 100%
  --ansi
  --no-scrollbar
  --list-border=none
  --info=hidden
  --preview-window=right:50%:border-left
  --pointer ''
  --marker ''
  --input-label=' Input '
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
  --color=bg+:${DRACULA_GREEN},fg+:${DRACULA_WHITE},fg:${DRACULA_WHITE},prompt:${DRACULA_WHITE}
"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

fif() {
  if [ "$#" -eq 0 ]; then
    echo "Need a string to search for!"
    return 1
  fi

  local file
  file="$(rga --ignore-case --files-with-matches --no-messages "$*" |
    fzf  --preview="rga --ignore-case --pretty --context 10 '$*' {}")"

  if [ -n "$file" ]; then
    echo "opening $file"
    nvim "$file"
  else
    return 1
  fi
}


fid() {
  if [ "$#" -eq 0 ]; then
    echo "Need a filename or folder pattern to search for!"
    return 1
  fi

  local file
  file="$(find . -maxdepth 1 \( -type f -o -type d \) -print 2>/dev/null |
    fzf --query="$*" --preview='
      if [ -d {} ]; then
        eza --no-quotes --color=always --long --sort=type --all --git --icons=always --no-filesize --no-time --no-user --no-permissions {}
      else
        bat --style=numbers --color=always --line-range=:100 {}
      fi
    ')"

  if [ -n "$file" ]; then
    echo "opening $file"
    nvim "$file"
  else
    return 1
  fi
}
