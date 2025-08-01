#!/usr/bin/env sh

/opt/homebrew/bin/sketchybar --reload &&
  sleep 0.5 &&
  /opt/homebrew/bin/sketchybar --trigger user_notification LABEL="Sketchybar reloaded" &&
  sleep 3 &&
  /opt/homebrew/bin/sketchybar --trigger user_notification LABEL="NORMAL MODE"
