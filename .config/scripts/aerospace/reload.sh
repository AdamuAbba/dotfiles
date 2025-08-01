#!/usr/bin/env sh

/opt/homebrew/bin/aerospace reload-config &&
  /opt/homebrew/bin/sketchybar --trigger user_notification LABEL="Aerospace reloaded" &&
  sleep 3 &&
  /opt/homebrew/bin/sketchybar --trigger user_notification LABEL="NORMAL MODE"
