#!/usr/bin/env bash
# Installs MDrop: a macOS Dock app that converts dropped PDFs to Markdown,
# with OCR fallback for scanned pages. See README.md for details.
set -euo pipefail

APP_DIR="$HOME/Applications/MDrop"
APP_BUNDLE="$HOME/Applications/MDrop.app"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "== MDrop installer =="

# 1. Homebrew
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Install it first: https://brew.sh"
  echo "Then re-run this script."
  exit 1
fi

# 2. Tesseract
if ! command -v tesseract >/dev/null 2>&1; then
  echo "Installing tesseract..."
  brew install tesseract
else
  echo "tesseract already installed."
fi

# 3. Python3 (prefer Homebrew's, since pip packages land there)
PYTHON_BIN="$(brew --prefix python3 2>/dev/null)/bin/python3"
if [ ! -x "$PYTHON_BIN" ]; then
  PYTHON_BIN="$(command -v python3)"
fi
echo "Using python3 at: $PYTHON_BIN"

# 4. Python packages
echo "Installing Python packages..."
"$PYTHON_BIN" -m pip install --user --break-system-packages -r "$SCRIPT_DIR/requirements.txt" \
  || "$PYTHON_BIN" -m pip install --user -r "$SCRIPT_DIR/requirements.txt"

# 5. Move mdrop.py into place
mkdir -p "$APP_DIR"
cp "$SCRIPT_DIR/mdrop.py" "$APP_DIR/mdrop.py"
echo "Copied mdrop.py to $APP_DIR/mdrop.py"

# 6. Build the droplet app
echo "Building $APP_BUNDLE..."
TMP_SCPT="$(mktemp -t mdrop).applescript"
cat > "$TMP_SCPT" <<EOF
on open theFiles
	repeat with aFile in theFiles
		set filePath to POSIX path of aFile
		do shell script "$PYTHON_BIN " & quoted form of "$APP_DIR/mdrop.py" & " " & quoted form of filePath
	end repeat
	display notification "Conversion complete" with title "MDrop"
end open
EOF

rm -rf "$APP_BUNDLE"
osacompile -o "$APP_BUNDLE" "$TMP_SCPT"
rm -f "$TMP_SCPT"

echo ""
echo "Done. MDrop.app is at: $APP_BUNDLE"
echo "Drag it onto your Dock to finish setup (Finder > open ~/Applications > drag MDrop.app to Dock)."
echo "Then drop a PDF onto the Dock icon to convert it to Markdown."
