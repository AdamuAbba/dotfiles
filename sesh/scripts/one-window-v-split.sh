#!/usr/bin/env bash

WINDOW_NAME="$1"

tmux rename-window "$WINDOW_NAME"
tmux split-window -h -c "#{pane_current_path}"
tmux select-pane -L

