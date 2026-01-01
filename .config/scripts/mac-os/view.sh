#!/usr/bin/env sh

file=$1

if [ -z "$TMUX" ]; then
  exec bat "$@"
fi

case $file in
*.md)
  if [ -f "$file" ]; then
    tmux display-popup \
      -w 80% \
      -h 90% \
      -T " MD Viewer   " \
      -d "#{pane_current_path}" \
      -E "nvim -M -R \
          +'set nonumber norelativenumber' \
          +'set laststatus=0' \
          +'LspStop' \
          \"$file\""
    exit 0
  fi
  ;;
esac

exec bat "$@"
