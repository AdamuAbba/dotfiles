#!/usr/bin/env sh

AVD_NAME="Medium_Phone_API_35"

EMULATOR_PATH="/Users/abba/Library/Android/sdk/emulator/emulator"

if [ ! -x "$EMULATOR_PATH" ]; then
  echo "Emulator binary not found at $EMULATOR_PATH"
  exit 1
fi

"$EMULATOR_PATH" -avd "$AVD_NAME" &
