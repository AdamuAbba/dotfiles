#!/bin/bash

CHOICE=$(echo -e "Single\nDual" |
  rofi -dmenu -p "Monitor Configs:" -theme ~/dotfiles/.config/rofi/powermenu/type-1/style-1.rasi)

# Move workspaces
singleDP() {
  xrandr --output eDP-1 --auto --output DP-2 --off
  i3-msg '[workspace="(2)"] move workspace to output eDP-1,workspace 2'
  notify-send -i display "Single monitor"
}
dualDP() {
  xrandr --output eDP-1 --auto --output DP-2 --auto --right-of eDP-1
  i3-msg '[workspace="(2)"] move workspace to output DP-2,workspace 2'
  notify-send -i display "Dual monitor"
}

case "$CHOICE" in
Single) singleDP ;;
Dual) dualDP ;;
esac
