#!/usr/bin/env sh

tmux select-window -l
tmux split-window -h -c '#{pane_current_path}'
tmux select-pane -L
clear
tmux select-window -t 1
