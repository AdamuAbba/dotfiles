#!/usr/bin/env bash

COMMAND="git status"
ADD_CICD=false

while [[ $# -gt 0 ]]; do
	case "$1" in
	-w)
		COMMAND="ls"
		shift
		;;
	-c)
		ADD_CICD=true
		shift
		;;
	*)
		shift
		;;
	esac
done

tmux new-window -n "  Commands"
tmux split-window -h -c "#{pane_current_path}"
tmux send-keys "$COMMAND" Enter
tmux select-pane -L
if [[ "$ADD_CICD" == true ]]; then
	tmux new-window -n "  CI/CD"
fi
tmux select-window -t 1
tmux rename-window "  Editor"
tmux send-keys "nvim -c 'lua require(\"persistence\").load()'" Enter
