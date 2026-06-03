#!/bin/bash

CURRENT=$(defaults read .GlobalPreferences _HIHideMenuBar 2>/dev/null || echo 0)

if [ "$CURRENT" -eq 1 ]; then
	osascript -e 'tell application "System Events" to tell dock preferences to set autohide menu bar to false'
else
	osascript -e 'tell application "System Events" to tell dock preferences to set autohide menu bar to true'
fi
