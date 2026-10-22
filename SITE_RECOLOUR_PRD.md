# PRD: MDrop landing site recolour

Status: DRAFT, awaiting sign-off.

## Problem
The landing site (docs/index.html, GitHub Pages) uses an orange accent (#c2410c light, #ff8a4c dark) and an inline placeholder favicon. The new MDrop icon is navy #12324A, teal #2EC4B6 and yellow #FFC857. Orange next to yellow reads as a mistake, and the site does not look like it belongs to the app.

## Success criteria
- No orange left on the page, in light or dark mode, or in the favicon.
- Every text and button colour pair meets WCAG AA: 4.5:1 for body text, 3:1 for large text and UI borders. Measured, not eyeballed.
- Teal and yellow never carry text on a light background (they fail: about 2.2:1 and 1.5:1).
- Real icon assets are wired in: favicon, apple-touch icon, manifest, og:image.
- Layout, copy, animation and the light/dark toggle behave exactly as before.

## Scope
In:
- Colour tokens in the three :root blocks (light, dark via media query, dark via toggle), plus the few hard-coded colours (.page, .ghost shadows).
- Replace the inline favicon with icon/web assets copied into docs/.
- Replace the fake "M" dock tile in the hero animation (.dock i.me) with the real icon. Same size and animation.
- Add og:image and theme-color meta tags.

Out: copy changes, layout changes, new sections, wordmark, fonts, JavaScript behaviour.

## Proposed token map (to be tuned against measured contrast)

| Token | Light now | Light proposed | Dark now | Dark proposed |
|---|---|---|---|---|
| --bg | #fbfaf8 | #F7FAFB | #141311 | #0B1F2E |
| --fg | #1c1b19 | #12324A | #efede8 | #E8F0F4 |
| --muted | #6b6862 | #52626E | #9a968e | #9FB3C0 |
| --line | #e4e1db | #DCE5EA | #2c2a26 | #1E3A4F |
| --card | #ffffff | #FFFFFF | #1b1a17 | #102A3D |
| --code | #f3f1ec | #EEF3F6 | #1f1d1a | #0F2738 |
| --accent (buttons, fills) | #c2410c | #12324A | #ff8a4c | #2EC4B6 |
| --accent-fg | #fff | #FFFFFF | #141311 | #0B1F2E |
| accent for text (.num, .hl, h1 em, links) | same as --accent | #0D7377 | same | #2EC4B6 |
| highlight (new, sparing) | none | #FFC857 as underline or badge only | none | #FFC857 |
| --ok | keep | keep | keep | keep |

A new token, --accent-text, is needed because the button colour and the text-accent colour differ on the light theme.

## Constraints
- Single HTML file, no build step, no new dependencies.
- Stay within the three-colour palette plus neutrals. Neutrals are navy-tinted greys, not warm greys.
- Do not publish or push. Edits stay local until you review.

## Plan
1. Add --accent-text and swap the tokens in all three blocks. Point the accent-as-text rules at it.
2. Copy icon/web assets and the real icon into docs/. Replace the inline favicon, add manifest, apple-touch, theme-color, og:image.
3. Swap the fake dock tile for the real icon.
4. Measure contrast for every text and background pair, light and dark.
5. Screenshot desktop and mobile widths, light and dark. Check the animation still plays.
6. Show you the diff and screenshots. No commit until you say so.

## Risks
- Navy-on-navy: dark mode cards and the dock tile could blend. Mitigation: the icon has its own edge line, and cards use a lighter navy than the page.
- The page feels cold or flat with no warm colour. Mitigation: yellow highlights in the hero.
- og:image needs an absolute URL. Mitigation: open question 1.

## Open questions
1. What is the public URL of the site (for og:image and canonical)? I can read it from the repo's GitHub Pages settings if you want.
2. Swap the fake dock tile for the real icon (step 3)? Default: yes.
3. Dark mode background: navy-tinted (#0B1F2E) or keep near-black neutral? Default: navy-tinted.
