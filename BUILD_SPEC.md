# MDrop Droplet - Build Spec for Claude Code

## Goal
Package mdrop.py into a macOS Automator Application (droplet) that lives in
the Dock. Dropping one or more PDFs onto the icon converts each to Markdown
and saves the .md next to the source PDF. No window, no import step.

## Files provided
- mdrop.py: conversion script, native text extraction with OCR fallback

## Steps

1. Check dependencies, install if missing:
   - Python 3 (check `python3 --version`)
   - Homebrew (check `brew --version`)
   - tesseract via `brew install tesseract`
   - Python packages: `pip3 install pymupdf pytesseract pillow`

2. Move mdrop.py to a permanent location, e.g. `~/Applications/MDrop/mdrop.py`.

3. Build the Automator Application:
   - Open Automator, New Document, choose "Application"
   - Add action "Run Shell Script"
   - Set "Pass input" to "as arguments"
   - Shell: /bin/bash
   - Script:
     ```
     for f in "$@"
     do
       /usr/bin/python3 ~/Applications/MDrop/mdrop.py "$f"
     done
     osascript -e 'display notification "Conversion complete" with title "MDrop"'
     ```
   - Save as Application, name "MDrop", location ~/Applications

   If doing this headlessly instead of via Automator GUI, use `osacompile`
   to generate the .app from an AppleScript droplet that shells out to
   mdrop.py for each dropped file, then shows a notification. Equivalent
   behavior, avoids the GUI steps above.

4. Drag the built MDrop.app onto the Dock.

5. Test: drop a text-based PDF, confirm .md output. Drop a scanned PDF,
   confirm OCR fallback triggers and output is readable.

## Known limits (do not try to fix silently, flag to user instead)
- OCR output has no heading detection, raw text blocks only
- Tables in scanned pages will not reconstruct as Markdown tables
- Large PDFs (100+ pages) will be slow on OCR pages, no progress bar
