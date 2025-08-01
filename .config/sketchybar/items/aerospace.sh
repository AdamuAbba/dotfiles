##!/usr/bin/env bash

# Add container item for all workspaces

# Add and configure individual workspace items
sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
  aerospace=(
    background.color="$GREEN"
    label.font="$FONT:Bold:13.0"
    background.corner_radius=3
    background.height=20
    background.drawing=off
    label.padding_left=0
    label.padding_right=7
    padding_left=4
    padding_right=4
    label.align=center
    label="$sid"
    click_script="aerospace workspace $sid"
    script="$CONFIG_DIR/plugins/aerospace.sh $sid"
  )

  sketchybar --add item space."$sid" left \
    --set space."$sid" "${aerospace[@]}" \
    --subscribe space."$sid" aerospace_workspace_change
done
