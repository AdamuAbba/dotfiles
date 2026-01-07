#!/usr/bin/env sh

tmux new-window
tmux split-window -v -p 40 -c "#{pane_current_path}"
tmux select-pane -U
tmux split-window -h -c "#{pane_current_path}"
tmux select-pane -D
tmux send-keys "git status" Enter
tmux select-window -t 1
tmux send-keys "nvim -c 'lua require(\"persistence\").load()'" Enter
