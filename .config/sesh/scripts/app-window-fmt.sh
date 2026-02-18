#!/usr/bin/env bash

APP_WINDOW_NAME="$1"

if [ -z "$APP_WINDOW_NAME" ]; then
  echo "Usage: $0 <app_window_name>"
  exit 1
fi

tmux set status-left ""

tmux set window-status-current-format "\
#[fg=${DRACULA_GRAY},bg=${DRACULA_BLACK}]\
#[fg=#{?client_prefix,$DRACULA_PURPLE,$DRACULA_GREEN},bg=${DRACULA_GRAY},bold]${APP_WINDOW_NAME}\
#[default]#[bg=${DRACULA_GRAY}]\
#[fg=#{?client_prefix,$DRACULA_PURPLE,$DRACULA_GREEN},bg=${DRACULA_GRAY},bold]\
#[fg=${DRACULA_GRAY},bg=${DRACULA_BLACK}]\
"

tmux set status-right ""
