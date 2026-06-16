#!/bin/bash
set -e

export LC_ALL=C
export LANG=C

REPO_DIR="${1:-Telegram-iOS}"

echo "=== Applying Bobgram patches to $REPO_DIR ==="

# --- App name in Info.plist ---
INFOPLIST="$REPO_DIR/Telegram/Telegram-iOS/Info.plist"
if [ -f "$INFOPLIST" ]; then
  sed -i '' 's/<string>Telegram<\/string>/<string>Bobgram<\/string>/g' "$INFOPLIST"
  echo "[✓] Patched Info.plist"
else
  echo "[!] Info.plist not found at $INFOPLIST"
fi

# --- CFBundleDisplayName in all Info.plist files ---
find "$REPO_DIR" -name "Info.plist" | while read -r plist; do
  if grep -q "CFBundleDisplayName" "$plist" 2>/dev/null; then
    perl -i -0pe \
      's|(<key>CFBundleDisplayName</key>\s*<string>)Telegram(</string>)|${1}Bobgram${2}|g' \
      "$plist"
  fi
done
echo "[✓] Patched CFBundleDisplayName in all plists"

# --- Navigation title in main chats root view ---
find "$REPO_DIR" -name "*.swift" | xargs grep -rl '"Telegram"' 2>/dev/null | while read -r f; do
  sed -i '' 's/title = "Telegram"/title = "Bobgram"/g' "$f"
  sed -i '' 's/setTitle("Telegram"/setTitle("Bobgram"/g' "$f"
done
echo "[✓] Patched Swift UI titles"

# --- English localizable strings ---
EN_STRINGS="$REPO_DIR/submodules/TelegramStringResources/Sources/en.lproj/Localizable.strings"
if [ -f "$EN_STRINGS" ]; then
  sed -i '' 's/= "Telegram";/= "Bobgram";/g' "$EN_STRINGS"
  echo "[✓] Patched Localizable.strings"
fi

# --- InfoPlist.strings for home screen app name ---
find "$REPO_DIR" -name "InfoPlist.strings" | while read -r f; do
  sed -i '' 's/CFBundleDisplayName = "Telegram"/CFBundleDisplayName = "Bobgram"/g' "$f"
  sed -i '' 's/CFBundleName = "Telegram"/CFBundleName = "Bobgram"/g' "$f"
done
echo "[✓] Patched InfoPlist.strings"

echo ""
echo "=== Done. App will be named Bobgram ==="
