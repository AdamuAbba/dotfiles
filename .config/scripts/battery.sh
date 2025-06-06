#!/bin/sh

for pid in $(pidof -x battery); do
  if [ "$pid" != $$ ]; then
    kill -9 "$pid"
  fi
done

dir_icons=~/dotfiles/.config/scripts/icons/

# notify when below this percentage
warning_level=20

# how often to check battery status, in seconds
check_interval=60

while true; do
  path_to_battery=$(upower -e | grep BAT)
  battery_level=$(upower -i "$path_to_battery" | grep -E "percentage" | sed 's/[^0-9]//g')
  discharging=$(upower -i "$path_to_battery" | grep -E "state" | grep -c "discharging")
  time_to_empty=$(upower -i "$path_to_battery" | grep -E "time to empty" | sed 's/[^0-9,.]//g')

  # check if battery is low and discharging
  if [ "$battery_level" -lt "$warning_level" ] && [ "$discharging" -eq 1 ]; then
    dunstify -a "Battery" \
      "Low battery: ${battery_level}%" \
      "Battery is low ($time_to_empty minutes left)" \
      -r 100 \
      -i $dir_icons/battery.svg
  fi

  sleep ${check_interval}s
done
