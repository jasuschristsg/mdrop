# PRD: MDrop Droplet

## Problem
A macOS Dock app: drop a PDF, get a Markdown file, no window, no import
step. Existing options are either windowed/single-file, or browser-based
tools with no OCR support for scanned pages.

## Goal
Drag one or more PDFs onto the Dock icon. Each PDF converts to a Markdown
file, saved next to the source. Notification on completion, no app window.

## Scope

In scope:
- Native text extraction, with OCR fallback for scanned/image pages
- Multi-file drop handled in a single pass
- Fully offline, no uploads or API calls

Out of scope (v1):
- Batch progress indicator
- Heading/structure detection in OCR output (raw text blocks only)
- Table reconstruction in scanned pages
- Windows/Linux support

## Known limitations, accepted for v1
- OCR text has no heading structure, flat text blocks per page
- Tables in scanned pages will not come out as Markdown tables
- Large PDFs with many scanned pages will be slow, no progress feedback
