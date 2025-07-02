#!/usr/bin/env bash

sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
  aerospace=(
    background.color="$GREEN"
    background.corner_radius=7
    background.height=20
    background.drawing=off
    # background.border_color="$PURPLE"
    label.padding_left=5
    label.padding_right=10
    padding_left=-8
    label.align=center
    label="$sid"
    click_script="aerospace workspace $sid"
    script="$CONFIG_DIR/plugins/aerospace.sh $sid"
  )

  sketchybar --add item space."$sid" left
  sketchybar --subscribe space."$sid" aerospace_workspace_change
  sketchybar --set space."$sid" "${aerospace[@]}"
done
