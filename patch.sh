#!/bin/bash
set -e

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
    # Replace display name only when it's "Telegram"
    perl -i -0pe \
      's|(<key>CFBundleDisplayName</key>\s*<string>)Telegram(</string>)|${1}Bobgram${2}|g' \
      "$plist"
  fi
done
echo "[✓] Patched CFBundleDisplayName in all plists"

# --- Navigation title in main chats root view ---
# Telegram-iOS sets the title in ChatListController or RootController
find "$REPO_DIR" -name "*.swift" | xargs grep -l '"Telegram"' 2>/dev/null | while read -r f; do
  # Only replace standalone "Telegram" string literals used as UI titles
  sed -i '' 's/title = "Telegram"/title = "Bobgram"/g' "$f"
  sed -i '' 's/setTitle("Telegram"/setTitle("Bobgram"/g' "$f"
done
echo "[✓] Patched Swift UI titles"

# --- English localizable strings ---
EN_STRINGS="$REPO_DIR/submodules/TelegramStringResources/Sources/en.lproj/Localizable.strings"
if [ -f "$EN_STRINGS" ]; then
  # Only patch lines where value is literally "Telegram" (app name keys)
  sed -i '' 's/= "Telegram";/= "Bobgram";/g' "$EN_STRINGS"
  echo "[✓] Patched Localizable.strings"
fi

# Catch InfoPlist.strings for the home screen app name
find "$REPO_DIR" -name "InfoPlist.strings" | while read -r f; do
  sed -i '' 's/CFBundleDisplayName = "Telegram"/CFBundleDisplayName = "Bobgram"/g' "$f"
  sed -i '' 's/CFBundleName = "Telegram"/CFBundleName = "Bobgram"/g' "$f"
done
echo "[✓] Patched InfoPlist.strings"

echo ""
echo "=== Done. App will be named Bobgram ==="
