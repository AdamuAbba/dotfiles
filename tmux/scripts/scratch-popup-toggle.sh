#!/usr/bin/env bash
set -euo pipefail

SESSION="scratch"
TITLE=" Scratch Session (Floating) "

current_session="$(tmux display-message -p '#{session_name}')"

#-- If we're inside the scratch session (popup), hide it
if [ "$current_session" = "$SESSION" ]; then
  tmux detach-client
  exit 0
fi

#-- Ensure session exists and has status off
if ! tmux has-session -t "$SESSION" 2>/dev/null; then
  tmux new-session -d -s "$SESSION" -c "#{pane_current_path}"
fi
tmux set-option -t "$SESSION" status off

#-- Show popup and attach to the session
tmux display-popup \
  -d "#{pane_current_path}" \
  -w 75% \
  -h 75% \
  -T "$TITLE" \
  -E "tmux attach -t $SESSION"
