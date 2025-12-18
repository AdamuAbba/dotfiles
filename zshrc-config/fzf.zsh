# -- Use fd instead of fzf --
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always --long --git --icons=always --no-filesize --no-time --no-user --no-permissions {}  | head -200; else bat -n --color=always --line-range :500 {}; fi"

export DISABLE_FZF_KEY_BINDINGS=true

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"

export FZF_DEFAULT_OPTS="
  --style=full
  --height 100%
  --input-label=' Input '
  --bind='result:transform-list-label:
    if [[ -z \$FZF_QUERY ]]; then
      echo \" \$FZF_MATCH_COUNT items \"
    else
      echo \" \$FZF_MATCH_COUNT matches for [\$FZF_QUERY] \"
    fi'
  --bind='focus:transform-preview-label:[[ -n {} ]] && printf \" Previewing [%s] \" {}'
  --bind='focus:+transform-header:file --brief {} || echo \"No file selected\"'
  --color=border:#50fa7b,label:#ffffff
  --color=preview-border:#50fa7b,preview-label:#ffffff
  --color=list-border:#bd93f9,list-label:#ffffff
  --color=input-border:#bd93f9,input-label:#ffffff 
  --color=header-border:#bd93f9,header-label:#ffffff 
  --color=bg:#000000
"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

_fzf_comprun() {
  local command=$1
  shift
 
  # case "$command" in
  #   cd)           fzf --preview 'eza --tree --color=always --long --git --icons=always --no-filesize --no-time --no-user --no-permissions {} | head -200' "$@" ;;
  #   ls)           fzf --preview 'eza --tree --color=always --long --git --icons=always --no-filesize --no-time --no-user --no-permissions {} | head -200' "$@" ;;
  #   eza)          fzf --preview 'eza --tree --color=always --long --git --icons=always --no-filesize --no-time --no-user --no-permissions {} | head -200' "$@" ;;
  #   export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
  #   ssh)          fzf --preview 'dig {}'                   "$@" ;;
  #   *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  # esac
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
