#!/usr/bin/env sh
set -eu

open_viewer() {
  if [ "${1:-}" = "-" ] || [ "$#" -eq 0 ]; then
    tmp="$(mktemp "${TMPDIR:-/tmp}/view.XXXXXX")"
    cat >"$tmp"
    trap 'rm -f "$tmp"' EXIT INT TERM HUP
    file="$tmp"
  else
    file="$1"
  fi

  NVIM_VIEWER=1 nvim -R \
    +'set laststatus=0' \
    +'set nonumber' \
    +'nnoremap <buffer> q :q<CR>' \
    "$file"
}

open_viewer "$@"
