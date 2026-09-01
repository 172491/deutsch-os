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

# 1.8 hotfix: ts-fsrs@5.4.1 scheduler.next() accepts Grade (Again/Hard/Good/Easy),
# not the wider Rating enum that also includes Manual=0.
python3 - <<'PY'
from pathlib import Path
p = Path('.cloudflare-build/deutsch-os-v1.8/src/fsrs.ts')
s = p.read_text(encoding='utf-8')
old_import = "import { createEmptyCard, fsrs, Rating, type Card } from 'ts-fsrs'"
new_import = "import { createEmptyCard, fsrs, Rating, type Card, type Grade } from 'ts-fsrs'"
old_map = "const ratingMap: Record<ReviewRating, Rating> = {"
new_map = "const ratingMap: Record<ReviewRating, Grade> = {"
if old_import not in s or old_map not in s:
    raise SystemExit('ERROR: expected fsrs.ts source pattern not found; refusing silent patch')
s = s.replace(old_import, new_import).replace(old_map, new_map)
p.write_text(s, encoding='utf-8')
print('Applied ts-fsrs Grade typing hotfix')
PY

cd "$APP_DIR"
npm install
npm run build
cd ../..
cp -R "$APP_DIR/dist" ./dist

echo "Deutsch OS 1.8 build complete: ./dist"
