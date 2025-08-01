#!/bin/bash

notification=(
  icon.drawing=on
  label.font="$FONT:Black:13.0"
  label.width=145
  label.align=center
  updates=on
  label.color="$BLACK"
  script="$PLUGIN_DIR/notification.sh"
)

sketchybar --add event user_notification \
  --add item notification right \
  --set notification "${notification[@]}" \
  --subscribe notification user_notification
