---
name: submission-pack
description: Builds the submission bundle — anonymization sweep for double-blind review (self-citations, acknowledgments, metadata), word-count and format checks against the journal's limits, title-page separation, final checklist. Use when the user is about to submit or asks to anonymize or format the manuscript for a journal.
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

**Stage:** submit · **Voice:** production-editor

After `/mstack:journal-fit` and a final manuscript. Everything else in MStack front-runs the reviewers; this front-runs the desk: the mechanical checks that bounce papers before anyone reads them.

`$ARGUMENTS` is the journal; default the tier-1 journal in `.mstack/config.yaml`.

## Procedure

1. **Journal requirements.** WebFetch the author guidelines or ask the user; never trust memory for word caps, anonymization policy, abstract limits, or reference style. Record: word cap and what counts toward it, abstract cap, double-blind y/n, figure / table placement, reference style, supplementary-material policy.
2. **Anonymization sweep** (double-blind journals): grep `paper/` for every author name and affiliation in `.mstack/config.yaml`; recast self-identifying citations ("our previous work", "as we showed (Name YEAR)") in the third person or as "Author (YEAR)" per the journal's convention, never deleting the citation itself; move acknowledgments, grant numbers, institution-tied IRB numbers, and `\thanks{}` / `\author{}` content into `paper/title-page.tex`, outside the anonymized build; note that the compiled PDF's document properties must not carry author names.
3. **Compliance:** word count vs. the cap (`texcount main.tex -inc -total` if available, else a documented approximation), stating count and margin; abstract length vs. its cap; reference style vs. what the bibliography actually produces; figures / tables count, placement (embedded vs. end), resolution.
4. **Bundle.** Compile the anonymized manuscript and the title page separately (`latexmk` / `pdflatex` or `quarto render`; without a TeX toolchain, stage the sources and list the compile steps). Stage under `submission/<journal-slug>/`: anonymized PDF, title page, figures at spec, supplementary material, and the prereg URL if `design.prereg` is true.
5. **Checklist** to `submission/submission-checklist-<YYYY-MM-DD>.md`: every check with pass / fail and evidence (grep counts, word counts, file list).
6. **Gate.** Not ready while any identifying string remains in the anonymized sources (show the grep proof) or any check fails without a user-acknowledged waiver.

## Outputs

- `submission/<journal-slug>/` bundle; `paper/title-page.tex`; `submission/submission-checklist-<date>.md`.
- Summary block: word count vs. cap, anonymization result, remaining manual steps (portal fields, PDF metadata).

## Anti-patterns

- **Anonymizing by deletion.** Use the journal's anonymous convention; never drop the reference.
- **Remembered journal rules.** Fetch or ask; caps and policies change between volumes.
- **"Probably fine" on identity.** One grep hit is a desk reject; the sweep ends at zero hits or an explicit waiver (single-blind journals).

## Next

`/mstack:cover-letter` for the same journal, then submit; `/mstack:referee-mock editor` beforehand stress-tests fit. Set `paper.status: "submitted"` in `.mstack/config.yaml` once the portal confirms.
