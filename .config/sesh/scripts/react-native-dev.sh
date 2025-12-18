#!/usr/bin/env sh

tmux new-window
tmux split-window -h -c "#{pane_current_path}"
tmux select-window -t 1
tmux send-keys "nvim +'lua Snacks.picker(\"files\", { root = false, layout = \"select_with_preview\" })'" Enter
