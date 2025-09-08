#!/bin/bash

source "$CONFIG_DIR/colors.sh"

update() {
  source "$CONFIG_DIR/icons.sh"
  SSID="$(/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | awk -F ' SSID: ' '/ SSID: / {print $2}')"
  IP="$(ipconfig getifaddr en0)"

  ICON="$([ -n "$IP" ] && echo "$WIFI_CONNECTED" || echo "$WIFI_DISCONNECTED")"
  ICON_COLOR="$([ -n "$IP" ] && echo "$GREEN" || echo "$RED")"
  LABEL="$([ -n "$IP" ] && echo "$SSID ($IP)" || echo "Disconnected")"

  sketchybar --set "$NAME" icon="$ICON" label="$LABEL" icon.color="$ICON_COLOR"
}

case "$SENDER" in
"wifi_change")
  update
  ;;
esac
