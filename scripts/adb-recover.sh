#!/usr/bin/env bash

set -euo pipefail

SERIAL="${1:-5bae07f50407}"
ADB="${ADB_PATH:-/Users/apple/Library/Android/sdk/platform-tools/adb}"

if [ ! -x "$ADB" ]; then
  echo "ADB not found or not executable at: $ADB" >&2
  echo "Set ADB_PATH or edit this script." >&2
  exit 1
fi

echo "Using adb: $ADB"
echo "Target serial: $SERIAL"

"$ADB" start-server >/dev/null 2>&1 || true
STATE="$("$ADB" -s "$SERIAL" get-state 2>/dev/null || true)"

if [ "$STATE" != "device" ]; then
  echo "ADB state is '$STATE' (expected 'device'). Recovering..."
  "$ADB" kill-server
  "$ADB" start-server
  "$ADB" disconnect >/dev/null 2>&1 || true
  "$ADB" reconnect >/dev/null 2>&1 || true
  sleep 2
fi

echo
echo "Current devices:"
"$ADB" devices -l
echo
echo "Recent logcat line:"
"$ADB" -s "$SERIAL" shell -x logcat -v time -t 1
