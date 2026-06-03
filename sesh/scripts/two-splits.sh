#!/usr/bin/env bash

COMMAND="git status"
ADD_CICD=false

while [[ $# -gt 0 ]]; do
	case "$1" in
	-c)
		ADD_CICD=true
		shift
		;;
	*)
		shift
		;;
	esac
done

tmux new-window -n "Commands"
tmux split-window -h -c "#{pane_current_path}"
tmux send-keys "$COMMAND" Enter
tmux select-pane -L
tmux send-keys "tmux select-window -t 1" Enter
sleep 2s
tmux rename-window "Editor"
tmux send-keys "nvim -c 'lua require(\"persistence\").load()'" Enter
if [[ "$ADD_CICD" == true ]]; then
	tmux new-window -n "CI/CD"
fi
