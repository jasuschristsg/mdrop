# MDrop

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
![Platform](https://img.shields.io/badge/platform-macOS-lightgrey)
![Python](https://img.shields.io/badge/python-3-blue)

A macOS Dock app: drag one or more PDFs onto the icon, get a Markdown file
per PDF, saved next to the source. No window, no import step, no manual
restart between drops.

Handles native text extraction for regular PDFs and falls back to Tesseract
OCR for scanned/image-only pages, inserting the OCR text at the correct page
position.

Runs fully offline. No uploads, no API calls, no subscription.

## Features

- Drop one or more PDFs on the Dock icon, get a `.md` file per PDF
- Native text extraction, with automatic OCR fallback per page
- Multi-file drops handled in one pass, no restart needed
- macOS notification on completion
- 100% offline, no accounts, no cost

## Requirements

- macOS (Apple Silicon or Intel)
- [Homebrew](https://brew.sh)
- Python 3

## Install

```bash
git clone https://github.com/jasuschristsg/mdrop.git
cd mdrop
./install.sh
```

The script installs `tesseract` via Homebrew, installs the required Python
packages (`pymupdf`, `pytesseract`, `pillow`), copies `mdrop.py` into
`~/Applications/MDrop/`, and builds `~/Applications/MDrop.app`.

Last step is manual: open `~/Applications` in Finder and drag `MDrop.app`
onto your Dock.

## Usage

Drag one or more PDFs onto the MDrop Dock icon. Each PDF gets a `.md` file
next to it, same name, same folder. A macOS notification fires on
completion.

## How it works

- `mdrop.py` extracts native text per page where available.
- Pages with no extractable text (scanned/image pages) are rendered and run
  through Tesseract OCR.
- Output is one Markdown file per PDF, with an HTML comment marking each
  page and whether it came from native text or OCR.

## Known limitations (v1)

- OCR output is flat text with no heading structure.
- Tables in scanned pages do not reconstruct as Markdown tables.
- Large PDFs with many scanned pages will be slow, with no progress bar.
- No GUI beyond the Dock icon and system notification, by design.

See [PRD.md](PRD.md) for full requirements and [BUILD_SPEC.md](BUILD_SPEC.md)
for the technical build steps.

## Uninstall

```bash
rm -rf ~/Applications/MDrop ~/Applications/MDrop.app
```

Then remove the icon from your Dock, and optionally `brew uninstall tesseract`.

## License

MIT, see [LICENSE](LICENSE).
