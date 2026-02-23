#!/bin/bash

front_app=(
  label.font="$FONT:Black:12.0"
  icon.background.drawing=on
  icon.background.image.scale=0.8
  icon.background.image.y_offset=-1
  label.align=center
  display=active
  script="$PLUGIN_DIR/front_app.sh"
  click_script="open -a 'Mission Control'"
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

sketchybar --add item front_app "$pos" \
  --set front_app "${front_app[@]}" \
  --subscribe front_app front_app_switched
