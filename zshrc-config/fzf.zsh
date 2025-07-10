# -- Use fd instead of fzf --
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always --long --git --icons=always --no-filesize --no-time --no-user --no-permissions {}  | head -200; else bat -n --color=always --line-range :500 {}; fi"

export DISABLE_FZF_KEY_BINDINGS=true

# source <(fzf --zsh)

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"

export FZF_DEFAULT_OPTS="
  --style=full
  --border --padding=1,2
  --input-label=' Input ' --header-label=' File Type '
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

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always --long --git --icons=always --no-filesize --no-time --no-user --no-permissions {} | head -200' "$@" ;;
    ls)           fzf --preview 'eza --tree --color=always --long --git --icons=always --no-filesize --no-time --no-user --no-permissions {} | head -200' "$@" ;;
    eza)          fzf --preview 'eza --tree --color=always --long --git --icons=always --no-filesize --no-time --no-user --no-permissions {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

fif() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    local file
    file="$(rga --max-count=1 --ignore-case --files-with-matches --no-messages "$*" | fzf-tmux +m --preview="rga --ignore-case --pretty --context 10 '"$*"' {}")" && echo "opening $file" && open "$file" || return 1;
}

