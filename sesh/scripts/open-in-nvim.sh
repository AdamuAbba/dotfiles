#!/usr/bin/env bash

WINDOW_NAME="$1"

tmux select-window -t 1
tmux rename-window "$WINDOW_NAME"
