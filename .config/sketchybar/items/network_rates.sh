#!/bin/bash

down=(
  icon=􁾯
  icon.color="$PURPLE"
  icon.padding_right=0
  background.border_width=1.8
  label.width=65
  label.align=center
  script="$PLUGIN_DIR/network_rates.sh"
  update_freq=2
)

pos="right"
MODE=$(cat "$HOME/.workspace_mode" 2>/dev/null || echo laptop)
case "$MODE" in
desktop)
  pos="center"
  ;;
*)
  pos="right"
  ;;
esac

sketchybar \
  --add item net_down "$pos" \
  --set net_down "${down[@]}"
