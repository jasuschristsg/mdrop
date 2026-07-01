# PRD: MDrop Droplet

## Problem
Need a Peggy-style Dock app: drop a PDF, get a Markdown file, no window, no
import step. Existing App Store options (MDrop) are windowed, single-file,
friction-heavy. Web tools (pdf2md.ch, pdf2md.net) require a browser tab and
don't handle OCR for scanned pages.

## Goal
A macOS Dock application. Drag one or more PDFs onto the icon. Each PDF is
converted to a Markdown file, saved next to the source. Notification on
completion. No app window, no manual import.

## User
Single user (Jasper), personal tool, local machine only. No multi-user,
no sync, no cloud component.

## Requirements

### Functional
1. Accept one or more PDFs dropped on the Dock icon in a single drop.
2. For each PDF: extract text natively where present.
3. For pages with no extractable text (scanned/image pages): OCR via
   Tesseract, insert result into the Markdown at the correct page position.
4. Output: one .md file per input PDF, same filename, same folder as source.
5. macOS notification on completion, silent otherwise (no window, no
   progress bar in v1).
6. Runs fully offline. No uploads, no API calls.

### Non-functional
- No install step beyond one-time setup (Homebrew, pip packages, tesseract).
- No cost, no subscription, no third-party service.
- No file size or page count cap, but explicitly not optimized for speed
  on OCR-heavy large PDFs in v1.

### Out of scope (v1)
- Batch progress indicator
- Heading/structure detection in OCR output (raw text blocks only)
- Table reconstruction in scanned pages
- Any GUI beyond the Dock icon and system notification
- Windows/Linux support

## Success criteria
- Drop a text-based PDF, .md appears next to it within seconds, headings
  and body text readable.
- Drop a scanned PDF, .md appears with OCR text, no crash, no manual
  restart required between drops (multi-file drop works in one go).
- No dead-end UI, no window to close and reopen (the MDrop app flaw).

## Known limitations, accepted for v1
- OCR text has no heading structure, flat text blocks per page
- Tables in scanned pages will not come out as Markdown tables
- Large PDFs with many scanned pages will be slow, no progress feedback
