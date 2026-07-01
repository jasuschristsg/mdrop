# Instructions for Claude Code

Read PRD.md first for requirements and scope. Read BUILD_SPEC.md for the
technical build steps. mdrop.py is the conversion script, already written,
do not rewrite it unless it fails testing.

## Task order

1. Check for and install dependencies listed in BUILD_SPEC.md step 1.
   Ask before running `brew install` if Homebrew is not already present,
   that's a system-level install.

2. Move mdrop.py into ~/Applications/MDrop/.

3. Build the Dock app per BUILD_SPEC.md step 3. Use osacompile if you can
   do it headlessly without the Automator GUI, that's the faster path.
   Only fall back to walking me through Automator GUI steps if osacompile
   doesn't get you a working droplet.

4. Test per BUILD_SPEC.md step 5:
   - One text-based PDF, confirm .md output quality
   - One scanned/image PDF, confirm OCR fallback fires and output is
     readable
   - One multi-file drop (2+ PDFs at once), confirm no dead-end, no
     restart required

5. If any test fails, fix and retest before reporting done. Do not report
   success on an untested assumption.

6. Report back: what was installed, where the app lives, what you tested,
   any of the PRD's known limitations that showed up in testing.

## Constraints
- Do not modify mdrop.py's conversion logic unless a test fails and the
  fix is in the script itself.
- Do not add scope beyond the PRD (no progress bar, no GUI window, no
  cloud/upload path).
- Confirm before any system-level install (Homebrew, tesseract) if not
  already present.
