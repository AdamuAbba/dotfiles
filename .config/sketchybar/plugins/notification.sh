#!/usr/bin/env sh

sketchybar --set "$NAME" label="${LABEL}"

sleep 3

sketchybar --set "$NAME" label=""
