#!/usr/bin

source "$ITEM_DIR/apple.sh"
source "$ITEM_DIR/aerospace.sh"

container=(
  background.color="$BLACK"
  background.corner_radius=10
  background.height=30
  background.border_color="$PURPLE"
  label.align=center
)

sketchybar --add bracket workspace_container '/space\..*/' '/apple\.logo/' \
  --set workspace_container "${container[@]}"
