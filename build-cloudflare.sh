#!/usr/bin/env bash
set -euo pipefail

ZIP="deutsch-os-v1.8.zip"
WORK=".cloudflare-build"

if [ ! -f "$ZIP" ]; then
  echo "ERROR: $ZIP not found in repository root."
  exit 1
fi

rm -rf "$WORK" dist
mkdir -p "$WORK"
unzip -q "$ZIP" -d "$WORK"

APP_DIR="$WORK/deutsch-os-v1.8"
if [ ! -f "$APP_DIR/package.json" ]; then
  echo "ERROR: package.json not found at $APP_DIR"
  find "$WORK" -maxdepth 3 -type f | head -50
  exit 1
fi

cd "$APP_DIR"
npm install
npm run build
cd ../..
cp -R "$APP_DIR/dist" ./dist

echo "Deutsch OS 1.8 build complete: ./dist"
