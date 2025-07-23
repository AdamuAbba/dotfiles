#!/bin/bash

notification=(
  icon=""
  icon.drawing=on
  label.max_chars=30
  updates=on
  label.color="$GREEN"
  script="$PLUGIN_DIR/notification.sh"
)

sketchybar --add event user_notification \
  --add item notification right \
  --set notification "${notification[@]}" \
  --subscribe notification user_notification
