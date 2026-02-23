#!/usr/bin/env bash

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.drawing=on label.color=0xff000000
else
  sketchybar --set $NAME background.drawing=off label.color=0xfff8f8f2
fi
