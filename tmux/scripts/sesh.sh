#!/usr/bin/env bash
set -euo pipefail

DRACULA_WHITE="#ffffff"

SESSION="scratch"

current_session="$(tmux display-message -p '#{session_name}')"

#-- If we're inside the scratch session (popup), do nothing
if [ "$current_session" = "$SESSION" ]; then
  exit 0
fi

sesh connect "$(
  sesh list -t -c --hide-duplicates | fzf --tmux 50%,50% \
    --padding=0,0,0,1.5% \
    --preview-window hidden \
    --border=rounded \
    --border-label=" Sesh " \
    --color=label:bold:${DRACULA_WHITE} \
    --color=border:bold:${DRACULA_WHITE} \
    --color=input-border:${DRACULA_WHITE},input-label:${DRACULA_WHITE} \
    --color=prompt:${DRACULA_WHITE} \
    --border-label-pos=3 \
    --input-border \
    --prompt "⚡ " \
    --bind "ctrl-d:execute(tmux kill-session -t {2..})+reload(sesh list -t -c --hide-duplicates)"
)"
