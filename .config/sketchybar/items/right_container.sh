#!/usr/bin

source "$ITEM_DIR/calendar.sh"
source "$ITEM_DIR/wifi.sh"
source "$ITEM_DIR/battery.sh"
source "$ITEM_DIR/volume.sh"
source "$ITEM_DIR/spotify.sh"
source "$ITEM_DIR/network_rates.sh"
source "$ITEM_DIR/front_app.sh"
source "$ITEM_DIR/notification.sh"

container=(
  background.color="$BLACK"
  background.corner_radius=10
  background.height=30
  background.border_color="$PURPLE"
  label.align=center
)

sketchybar --add bracket right_bracket notification calendar wifi net_down \
  --set right_bracket "${container[@]}"
