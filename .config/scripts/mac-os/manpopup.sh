#!/usr/bin/env sh

use_float=0

while getopts ":f" opt; do
  case "$opt" in
  f) use_float=1 ;;
  \?)
    echo "usage: $(basename "$0") [-f] <man-topic>" >&2
    exit 2
    ;;
  esac
done
shift $((OPTIND - 1))

topic="${1:-}"

if [ -z "$topic" ]; then
  echo "usage: $(basename "$0") [-f] <man-topic>" >&2
  exit 2
fi

# Default (no -f): run normally, no popup
if [ "$use_float" -eq 0 ]; then
  MANPAGER='NVIM_VIEWER=1 nvim +Man! \
    +"set laststatus=0" \
    +"nnoremap <buffer> q :q<CR>"' \
    command man "$topic"
  exit $?
fi

# -f requested: if not in tmux or already in a popup, fall back to normal
if [ -z "${TMUX:-}" ] || tmux display-message -p '#{popup_pane_id}' 2>/dev/null | grep -q .; then
  MANPAGER='NVIM_VIEWER=1 nvim +Man! \
    +"set laststatus=0" \
    +"nnoremap <buffer> q :q<CR>"' \
    command man "$topic"
  exit $?
fi

# -f requested and tmux available: open popup
tmux display-popup \
  -w 90% \
  -h 90% \
  -T " Manpages " \
  -d "#{pane_current_path}" \
  -E "MANPAGER=\"NVIM_VIEWER=1 nvim +Man! \
    +\\\"set laststatus=0\\\" \
    +\\\"nnoremap <buffer> q :q<CR>\\\"\" \
  command man \"$topic\""
