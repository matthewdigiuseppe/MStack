---
name: cover-letter
description: Drafts the three-paragraph submission cover letter — fit to this journal, contribution, declarations — in 400 words or fewer. Use after a target journal is chosen, when the user asks for a cover letter or submission materials.
allowed-tools:
  - Read
  - Write
  - Edit
---

# /mstack:cover-letter

**Stage:** submit · **Voice:** the author addressing the editor

After `/mstack:journal-fit`. Read in 30 seconds; precision beats warmth.

## Procedure

1. **Load** `.mstack/config.yaml` (top-tier target journal), `paper/sections/abstract.tex`, the contribution sentence in `.mstack/research-question.md`.
2. **Editor.** Ask the user for the current editor's name and salutation if not in config; editors change, so never guess from memory.
3. **Three paragraphs, ≤ 400 words:**
   - **Fit** — what the paper does in one sentence and why it belongs in *this* journal, naming one or two recent papers there it is in conversation with; not "builds on the journal's strong tradition in X".
   - **Contribution** — the contribution sentence from `/mstack:research-question`, the headline finding, and the design that delivers it. No hedging.
   - **Declarations** — preregistration status + URL (from config); data and code availability; not under review elsewhere; conflicts of interest; IRB approval if applicable; word count; prior presentations or earlier versions.
4. **Sign-off:** author name(s) and affiliation(s), one line.
5. **Save** to `submission/cover-letter.md` (Markdown; convert to whatever the portal accepts at submission).
6. **Cross-check:** editor correct and current; journal name spelled correctly throughout; within the journal's word limit; declarations cover everything the portal will ask.

## Outputs

- `submission/cover-letter.md`.
- Summary block: word count, editor addressed, declarations covered; remind the user to set `paper.status: "submitted"` once the portal confirms.

## Anti-patterns

- **Sycophancy.** Editors do not need to hear their journal is excellent.
- **Generic fit.** "Of interest to your readership" with no specific paper cited is noticeable.
- **Five paragraphs.** Three.
- **Repeating the abstract.** The letter situates the paper for this editor; the abstract cannot.

## Next

Submit. On decision: `/mstack:r-and-r` for an R&R; `/mstack:journal-fit` again after a rejection.
