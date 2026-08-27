---
name: submission-pack
description: Prepares the actual submission bundle — anonymization sweep for double-blind review (self-citations, acknowledgments, metadata), word-count and formatting checks against the target journal's limits, title-page separation, and a final checklist. Use when the user is about to submit or asks to anonymize or format the manuscript for a journal.
argument-hint: "[journal name]"
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
  - WebFetch
---

# /mstack:submission-pack

**Stage:** submit
**Voice:** production-editor

## When to invoke

After `/mstack:journal-fit` picks the journal and the manuscript is final. Everything else in MStack front-runs the reviewers; this skill front-runs the desk — the mechanical checks (anonymity, word count, formatting) that get papers bounced before anyone reads them.

## Argument

`$ARGUMENTS` (optional) — the journal to pack for. Defaults to the tier-1 journal in `.mstack/config.yaml`.

## Procedure

1. **Establish the journal's requirements.** WebFetch the journal's author guidelines, or ask the user for them; never trust memory for word caps, anonymization policy, abstract limits, or reference style — they change. Record: word cap (and what counts toward it), abstract cap, double-blind y/n, figure/table placement rules, reference style, supplementary-material policy.

2. **Anonymization sweep** (double-blind journals):
   - Grep `paper/` for every author name and affiliation from `.mstack/config.yaml`.
   - Find self-identifying citations — "our previous work", "as we showed (Name YEAR)" — and recast in third person or as "Author (YEAR)" per the journal's convention. Never delete the citation itself; that breaks the argument.
   - Strip or fence acknowledgments, thanks, grant numbers, IRB protocol numbers tied to an institution, and `\thanks{}`/`\author{}` content into a separate `paper/title-page.tex` that is NOT part of the anonymized build.
   - Note PDF metadata: the compiled anonymized PDF must not carry author names in its document properties.

3. **Compliance checks:**
   - Word count vs. the cap (`texcount main.tex -inc -total` if available; otherwise a documented approximation) — state the count and the margin.
   - Abstract length vs. the abstract cap.
   - Reference style vs. what the bibliography actually produces.
   - Figures/tables: count, placement (embedded vs. end-of-manuscript), and resolution requirements.

4. **Build the bundle.** Compile the anonymized manuscript and the title page separately (`latexmk`/`pdflatex`, or `quarto render`; if no TeX toolchain is available, stage the sources and list the manual compile steps). Stage everything under `submission/<journal-slug>/`: anonymized PDF, title page, figures at spec, supplementary material, and the prereg URL if `design.prereg` is true.

5. **Write the checklist** to `submission/submission-checklist-<YYYY-MM-DD>.md`: every check above with pass/fail and the evidence (grep counts, word counts, file list).

6. **Gate.** Refuse to declare the pack ready while any identifying string remains in the anonymized sources (show the grep proof), or any check fails without a user-acknowledged waiver.

## Outputs

- `submission/<journal-slug>/` — the staged bundle.
- `paper/title-page.tex` — identifying front matter, split out.
- `submission/submission-checklist-<date>.md` — pass/fail record.
- Summary block: word count vs. cap, anonymization result, remaining manual steps (portal fields, PDF metadata).

## Anti-patterns to refuse

- **Anonymizing by deletion.** Replace self-citations with the journal's anonymous convention; never drop the reference.
- **Trusting remembered journal rules.** Fetch or ask; caps and policies change between volumes.
- **"Probably fine" on identity.** One grep hit for an author's name is a desk reject; the sweep ends at zero hits or an explicit waiver (some journals are single-blind).

## When to call other skills

- Before: `/mstack:journal-fit` (chooses the journal), `/mstack:referee-mock editor` (fit stress-test).
- After: `/mstack:cover-letter` for the same journal; then submit. Remind the user to set `paper.status: "submitted"` in `.mstack/config.yaml` once the portal confirms.
