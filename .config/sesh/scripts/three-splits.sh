#!/usr/bin/env sh

tmux new-window -n "  Commands"
tmux split-window -v -p 40 -c "#{pane_current_path}"
tmux select-pane -U
tmux split-window -h -c "#{pane_current_path}"
tmux select-pane -D
tmux send-keys "git status" Enter
tmux select-window -t 1
tmux rename-window "  Editor"
tmux send-keys "nvim -c 'lua require(\"persistence\").load()'" Enter
