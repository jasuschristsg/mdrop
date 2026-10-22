# PRD: MDrop app icon (concept B, "twin drops", revised)

Status: APPROVED v2 (2026-10-22). Changes from v1 are marked **[NEW]**.

## Problem
MDrop is a macOS app. You drag a PDF onto its Dock icon and it creates a .md file in the same folder as the PDF. The Dock icon is the whole interface, so it has to say "drop" and "Markdown" with no caption.

The first sketch of concept B (two overlapping drops, one teal, one yellow) was liked but did not read as an M. The drops were too round and the valley between them was too deep, so the shape read as two separate drops or a "w".

## Goal
Redesign concept B so the first thing a viewer sees is the letter M, and the second is water drops.

## Success criteria
- At 32 px and 16 px, 5 of 5 reviewers name the letter M within two seconds, with no hint.
- At least 4 of 5 reviewers also say "drop" or "water" at 128 px.
- Reads clearly on both a light and a dark Dock.
- Distinct from the standard Markdown mark (rectangle with an M and a down arrow).
- Still reads as an M in one colour.
- **[NEW]** The icon renders correctly on a real install: after running install.sh, the Dock shows the new icon instead of the default AppleScript applet icon.

## Design direction
Keep: two drops, teal and yellow on a navy rounded-square tile.

Change, to make it read as M:
- Straighten the outer edges into near-vertical stems. Each stem is a drop with its tip at the top and a rounded base at the bottom.
- Make the two peaks the same height and symmetrical.
- Add a centre V that joins the stems and reaches about 50 to 60 percent of the way down. A shallow V reads as M. A deep valley reads as "w".
- Keep the base width equal to the height, so the M does not look squat.
- Use thick shapes with generous gaps. Thin parts disappear at 16 px.
- Keep the two-tone split (teal left, yellow right) only if the M still reads when the colours are removed. If it fails, use one colour and use the second colour as a small highlight.

Trade-off to manage: the more M-like the shape, the less drop-like it looks. Keep the pointed tips and rounded bases as the minimum drop cues. Do not add more cues.

## Scope
In: the app icon master, the macOS icon set, one-colour versions, a size test sheet, **[NEW]** the web and repo assets listed under deliverables 6 to 10.
Out: animation, the demo video, brand guidelines document, presentation board with mockups, Pantone/CMYK values (no print use).

**[NEW]** Wordmark: scope depends on open question 3. Default is a plain text lockup only (no custom letterforms).

## Constraints
- Use the macOS app icon grid and rounded-square template. Master canvas 1024 x 1024 px.
- Maximum three colours. The values below are placeholders, not brand colours: navy #12324A, teal #2EC4B6, yellow #FFC857. Swap them if a brand palette is supplied.
- Original artwork only. No stock assets, no fonts converted to outlines from a licensed typeface.
- Check which tools are installed (for example rsvg-convert, ImageMagick, iconutil) before using them. Do not install anything without asking.
- **[NEW]** The app is built on the user's machine by install.sh (osacompile), not shipped as a prebuilt bundle. The icon must be applied by that script.

## Deliverables

Core (v1):
1. mdrop-icon.svg (master, editable shapes)
2. mdrop-icon-1024.png
3. MDrop.iconset with all required sizes (16, 32, 128, 256, 512 at 1x and 2x), and MDrop.icns if iconutil is available
4. mdrop-icon-mono.svg (one colour)
5. size-test.png showing the icon at 128, 64, 32 and 16 px, on light and dark backgrounds

Additions **[NEW]**:
6. **Small-size cut** (mdrop-icon-small.svg): a separate drawing for 16 to 32 px with a thicker V and wider gaps. Used as the favicon source.
7. **One-colour set**: mdrop-icon-black.svg and mdrop-icon-white.svg (replaces the single mono file in item 4, which becomes the brand-colour variant).
8. **Tile-free symbol** (mdrop-symbol.svg): the M-drops on a transparent background with no navy tile. For the README header, site nav and tab icons.
9. **Web icon set** for the GitHub Pages landing site (docs/index.html): favicon.ico (16/32/48), favicon.svg, apple-touch-icon.png (180), icon-192.png, icon-512.png, site.webmanifest, and a `<head>` snippet.
10. **Social preview images**: og-image.png (1200 x 630) and github-social-preview.png (1280 x 640).
11. **Install integration**: a small change to install.sh to copy MDrop.icns into MDrop.app/Contents/Resources (replacing the default applet icon) and refresh the icon cache. Shown as a diff for approval before it is applied.

Conditional, only if the matching open question is answered yes **[NEW]**:
12. DROPPED (wordmark out).
13. DROPPED (no DMG).
14. DROPPED (layered macOS 26 icon skipped; revisit if the app moves to an Xcode build).

## Plan
1. Draw four geometry variants of the revised concept B. Vary the V depth (about 45, 55, and 65 percent) and the stem straightness.
2. Render all four on the size test sheet. Stop here and wait for my pick.
3. Refine the chosen variant: optical spacing, corner radii, highlight, colour balance.
4. **[NEW]** Draw the small-size cut and the tile-free symbol from the chosen variant.
5. Export all deliverables.
6. Check: the 16 px render, the one-colour render, and the dark Dock render. Report any that fail.
7. **[NEW]** Test on a real install: run the modified install.sh and confirm the Dock icon.

## Risks
- The M reads well but loses the drop feel. Mitigation: keep the pointed tips.
- The two-tone split breaks the M at small sizes. Mitigation: the one-colour fallback.
- Fine detail disappears at 16 px. Mitigation: design at 16 px first, then scale up.
- **[NEW]** macOS caches Dock icons, so a correct icon can look stale after install. Mitigation: the install step touches the bundle and restarts the Dock.

## Decisions (resolved)
1. Palette: a new MDrop palette, not JN brand colours. The navy, teal and yellow values above are the starting point and can be tuned in step 3.
2. Public sharing: yes, treat as public. Run a trademark search on the name and mark before any launch push. This PRD does not cover clearance.
3. Wordmark: out. Deliverable 12 is dropped. The README and site set "MDrop" as live text beside the icon.
4. DMG: no. Deliverable 13 is dropped. Distribution stays via install.sh.
6. Naming: "MDrop" on artwork and files (file slugs stay lowercase, for example mdrop-icon.svg).

## Open questions (none outstanding)
5. macOS 26 layered icon: skipped. Flat .icns only.
