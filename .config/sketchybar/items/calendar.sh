#!/bin/bash

calendar=(
  icon="󰃰 "
  icon.font="$FONT:Black:16"
  icon.padding_right=5
  icon.padding_left=15
  icon.color="$ORANGE"
  label.color="$WHITE"
  background.color=0x66494d64
  label.align=center
  label.padding_right=15
  update_freq=30
  y_offset=-1.5
  background.color="$BAR_COLOR"
  background.border_color="$PURPLE"
  background.border_width=1.5
  script="$PLUGIN_DIR/calendar.sh"
  # click_script="$PLUGIN_DIR/zen.sh"
)

sketchybar --add item calendar right \
  --set calendar "${calendar[@]}" \
  --subscribe calendar system_woke
