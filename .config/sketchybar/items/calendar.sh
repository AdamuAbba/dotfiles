#!/bin/bash

calendar=(
  icon="󰃰 "
  icon.font="$FONT:Black:16"
  label.font="$FONT:Black:12"
  icon.padding_right=13
  icon.padding_left=0
  icon.color="$ORANGE"
  label.color="$WHITE"
  label.align=center
  label.padding_right=15
  label.width=155
  update_freq=1
  y_offset=-1.5
  script="$PLUGIN_DIR/calendar.sh"
)

sketchybar --add item calendar right \
  --set calendar "${calendar[@]}" \
  --subscribe calendar system_woke
