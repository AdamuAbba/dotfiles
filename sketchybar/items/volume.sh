#!/bin/bash

volume_slider=(
  script="$PLUGIN_DIR/volume.sh"
  updates=on
  label.drawing=off
  icon.drawing=off
  slider.highlight_color="$PURPLE"
  slider.background.height=5
  slider.background.corner_radius=3
  slider.background.color=$BACKGROUND_2
  slider.knob=􀀁
  slider.knob.drawing=on
)

volume_icon=(
  click_script="$PLUGIN_DIR/volume_click.sh"
  padding_left=0
  icon="$VOLUME_100"
  icon.width=0
  icon.align=left
  icon.color="$GREY"
  icon.font="$FONT:Regular:14.0"
  label.width=25
  label.align=left
  label.font="$FONT:Regular:14.0"
)

status_bracket=(
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
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

sketchybar --add slider volume "$pos" \
  --set volume "${volume_slider[@]}" \
  --subscribe volume volume_change \
  mouse.clicked \
  \
  --add item volume_icon "$pos" \
  --set volume_icon "${volume_icon[@]}"

sketchybar --add bracket status brew github.bell wifi volume_icon \
  --set status "${status_bracket[@]}"
