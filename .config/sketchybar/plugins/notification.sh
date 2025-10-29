#!/usr/bin/env sh

label=${LABEL:-""}
color=${COLOR:-"0xffbd93f9"}

case "$label" in
"NORMAL MODE") color="0xffbd93f9" ;;
"APP MODE") color="0xff50fa7b" ;;
"SCRIPT MODE") color="0xfff1fa8c" ;;
"MEDIA MODE") color="0xffff79c6" ;;
"DISPLAY MODE") color="0xff8be9fd" ;;
"") color="" ;;
esac

sketchybar --set "$NAME" label="$label" background.color="$color"
