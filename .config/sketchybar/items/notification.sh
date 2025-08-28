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

pos="right"
MODE=$(cat "$HOME/.workspace_mode" 2>/dev/null || echo laptop)
case "$MODE" in
desktop)
  pos="center"
  ;;
*)
  pos="right"
  ;;
esac

sketchybar --add event user_notification \
  --add item notification "$pos" \
  --set notification "${notification[@]}" \
  --subscribe notification user_notification
