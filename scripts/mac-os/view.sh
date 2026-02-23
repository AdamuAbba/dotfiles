#!/usr/bin/env sh
file=$1

# Check if not in tmux or already in a popup
if [ -z "$TMUX" ] || tmux display-message -p '#{popup_pane_id}' | grep -q .; then
  exec bat "$@"
fi

open_viewer() {
  title="$1"
  file="$2"
  extra_cmds="$3"

  tmux display-popup \
    -w 80% \
    -h 90% \
    -T " $title " \
    -d "#{pane_current_path}" \
    -E "NVIM_VIEWER=1 nvim -R \
        +'set laststatus=0' \
        +'set nonumber' \
        +'nnoremap <buffer> q :q<CR>' \
        $extra_cmds \
        \"$file\""
}

case $file in
*.md)
  [ -f "$file" ] && open_viewer " MD " "$file" "+'set filetype=markdown'" && exit 0
  ;;
*.json)
  [ -f "$file" ] && open_viewer " JSON " "$file" "+'set filetype=json'" && exit 0
  ;;
*.py)
  [ -f "$file" ] && open_viewer " PY " "$file" "+'set filetype=python'" && exit 0
  ;;
*.js | *.ts)
  [ -f "$file" ] && open_viewer " JS/TS " "$file" "+'set filetype=javascript'" && exit 0
  ;;
*.tsx | *.jsx)
  [ -f "$file" ] && open_viewer " JSX/TSX " "$file" "+'set filetype=typescriptreact'" && exit 0
  ;;
*.rs)
  [ -f "$file" ] && open_viewer " rs " "$file" "+'set filetype=rust'" && exit 0
  ;;
*.toml)
  [ -f "$file" ] && open_viewer " TOML " "$file" && exit 0
  ;;
*.yml | *.yaml)
  [ -f "$file" ] && open_viewer " YAML " "$file" && exit 0
  ;;
esac

exec bat "$@"
