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
sketchybar \
  --add item net_down right \
  --set net_down "${down[@]}"
