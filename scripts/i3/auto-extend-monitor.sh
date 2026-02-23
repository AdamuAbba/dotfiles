#! /bin/bash

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

declare -a active_monitors=()

detected_monitors="$(xrandr | grep -w 'connected' | awk '{ print$1 }')"

for monitor in $detected_monitors; do
  active_monitors+=("$monitor")
done

array_lenght="${#active_monitors[@]}"

if (("$array_lenght" > 1)); then
  dualDP
else
  singleDP
fi
