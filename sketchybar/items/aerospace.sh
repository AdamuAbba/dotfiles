#!/usr/bin/env bash

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

  pos="left"
  MODE=$(cat "$HOME/.workspace_mode" 2>/dev/null || echo laptop)
  case "$MODE" in
  desktop)
    pos="center"
    ;;
  *)
    pos="left"
    ;;
  esac

  sketchybar --add item space."$sid" "$pos" \
    --set space."$sid" "${aerospace[@]}" \
    --subscribe space."$sid" aerospace_workspace_change
done
