#!/usr/bin/env sh

echo "[*] Getting booted simulator UDID..."
BOOTED_UDID=$(xcrun simctl list devices | grep -w "Booted" | awk -F '[()]' '{print $2}')
echo "[+] Booted simulator UDID: $BOOTED_UDID"

echo "[*] Focus simulator"
/opt/homebrew/bin/aerospace workspace Sims/VMs

echo "[*] Fetching frontmost app bundle ID..."
FRONT_APP_BUNDLE_ID="com.mindful.insights"

# $(xcrun simctl spawn "$BOOTED_UDID" launchctl print system |
#   grep "com.apple" | grep -E "PID|bundleid" | awk -F'=' '/bundleid/{print $2}' | head -1 | xargs)
echo "[+] Frontmost app bundle ID: $FRONT_APP_BUNDLE_ID"

if [ -z "$FRONT_APP_BUNDLE_ID" ]; then
  echo "[!] No app found in foreground. Exiting."
  exit 1
fi

echo "[*] Terminating app: $FRONT_APP_BUNDLE_ID"
xcrun simctl terminate "$BOOTED_UDID" "$FRONT_APP_BUNDLE_ID"

echo "[*] Relaunching app: $FRONT_APP_BUNDLE_ID"
xcrun simctl launch "$BOOTED_UDID" "$FRONT_APP_BUNDLE_ID"

echo "[✓] Done."
