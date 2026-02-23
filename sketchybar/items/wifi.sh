#!/bin/bash

source "$CONFIG_DIR/icons.sh"

wifi=(
  padding_right=7
  label.width=0
  icon="$WIFI_DISCONNECTED"
  script="$PLUGIN_DIR/wifi.sh"
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

sketchybar --add item wifi "$pos" \
  --set wifi "${wifi[@]}" \
  --subscribe wifi wifi_change mouse.clicked
