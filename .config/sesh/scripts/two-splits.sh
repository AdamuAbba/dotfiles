#!/usr/bin/env bash

COMMAND="git status"
if [[ "$1" == "-w" ]]; then
  COMMAND="ls"
fi

tmux new-window -n "  Commands"
tmux split-window -h -c "#{pane_current_path}"
tmux send-keys "$COMMAND" Enter
tmux select-pane -L
tmux select-window -t 1
tmux rename-window "  Editor"
tmux send-keys "nvim -c 'lua require(\"persistence\").load()'" Enter
