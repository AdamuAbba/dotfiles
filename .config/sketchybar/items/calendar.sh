#!/bin/bash

calendar=(
  icon=󰃰
  icon.font="$FONT:Black:12.0"
  icon.padding_right=10
  icon.padding_left=10
  label.width=45
  icon.color="$GREEN"
  label.color="$GREEN"
  background.color=0x66494d64
  label.align=right
  padding_left=15
  label.padding_right=15
  update_freq=30
  background.color="$BAR_COLOR"
  background.border_color="$PURPLE"
  background.border_width=2
  script="$PLUGIN_DIR/calendar.sh"
  # click_script="$PLUGIN_DIR/zen.sh"
)

sketchybar --add item calendar right \
  --set calendar "${calendar[@]}" \
  --subscribe calendar system_woke
