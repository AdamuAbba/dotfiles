#!/usr/bin/env sh

#TODO:
# since Karabiner runs scripts in a limited environment.
# refactor commands to use full path for all scripts.

aerospace reload-config && sketchybar --trigger user_notification LABEL="Aerospace config reloaded"
