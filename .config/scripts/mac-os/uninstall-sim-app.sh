#!/usr/bin/env bash

echo "[*] Getting booted simulator UDID..."
BOOTED_UDID=$(xcrun simctl list devices | grep -w "Booted" | awk -F '[()]' '{print $2}')
echo "[+] Booted simulator UDID: $BOOTED_UDID"

echo "[*] Focus simulator"
open -a Simulator

echo "[*] Fetching frontmost app bundle ID..."

KNOWN_FRONT_APP_BUNDLE_ID=(
  com.mindful.insights
  com.joinq.business
)

IS_BOOTED="$(xcrun simctl spawn booted launchctl list)"

FRONT_APP_BUNDLE_ID=""

for bid in "${KNOWN_FRONT_APP_BUNDLE_ID[@]}"; do
  if echo "$IS_BOOTED" | grep -q "$bid"; then
    FRONT_APP_BUNDLE_ID="$bid"
    break
  fi
done

echo "[+] Frontmost app bundle ID: $FRONT_APP_BUNDLE_ID"

if [ -z "$FRONT_APP_BUNDLE_ID" ]; then
  echo "[!] No app found in foreground. Exiting."
  exit 1
fi

echo "[*] Terminating app: $FRONT_APP_BUNDLE_ID"
xcrun simctl terminate "$BOOTED_UDID" "$FRONT_APP_BUNDLE_ID"

echo "[*] uninstalling app: $FRONT_APP_BUNDLE_ID"
xcrun simctl uninstall "$BOOTED_UDID" "$FRONT_APP_BUNDLE_ID"

echo "[✓] Done."
