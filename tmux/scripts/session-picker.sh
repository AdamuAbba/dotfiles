#!/usr/bin/env bash
set -euo pipefail

#-- tmux forbids ':' in session names, so it's a safe delimiter to recover the name
FORMAT='#{session_name}: #{session_windows} windows#{?session_attached, (attached),}'

#-- run-shell gets the tmux server's env, not zsh's, so point fzf at the shared opts file
export FZF_DEFAULT_OPTS_FILE="${FZF_DEFAULT_OPTS_FILE:-$HOME/.config/fzf/fzfrc}"

#-- Esc / ctrl-c makes fzf exit non-zero; treat that as "do nothing"
selected="$(
  tmux list-sessions -F "$FORMAT" |
    fzf \
      --tmux center,60%,50% \
      --border=rounded \
      --margin=0 \
      --list-border=none \
      --input-border=none \
      --prompt '' \
      --delimiter ':' \
      --bind 'result:ignore' \
      --bind "ctrl-d:execute-silent(tmux kill-session -t {1})+reload:tmux list-sessions -F '$FORMAT'"
)" || exit 0

#-- Switch to the chosen session
tmux switch-client -t "${selected%%:*}"
