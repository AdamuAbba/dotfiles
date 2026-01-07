#!/usr/bin/env sh

tmux new-window
tmux split-window -h -c "#{pane_current_path}"
tmux send-keys "git status" Enter
tmux select-pane -L
tmux select-window -t 1
tmux send-keys "nvim -c 'lua require(\"persistence\").load()'" Enter
