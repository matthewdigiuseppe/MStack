---
name: paper-status
description: Reports where a paper stands from its .mstack/ memory and pipeline outputs — stage, missing artifacts, stale verdicts, and the one recommended next skill. Use when the user asks where they left off or what's next, wants a status check, or opens a session on an existing paper.
allowed-tools:
  - Read
  - Grep
  - Glob
  - Edit
---

# /mstack:paper-status

**Stage:** any · **Voice:** project-manager

Opening a session, returning after a gap, "where were we?", "what's next?". Read-only apart from an offered `paper.status` correction.

## Procedure

1. **Locate** `.mstack/` in the current directory or an ancestor; if none, say so and suggest `/mstack:mstack-init`.
2. **Read `.mstack/config.yaml`:** title, `paper.status`, format, `design.prereg`, target journals.
3. **Inventory** each stage's artifacts, pulling the verdict line (grep `Verdict`) and the file date:

   | Stage | Artifacts |
   |---|---|
   | Ideate | `.mstack/research-question.md`, `idea-shotgun-*.md`, `scope-challenge-*.md` |
   | Map | `.mstack/lit-map.md`, `theory.md`, `hypotheses.md`, `identification-review-*.md` |
   | Design | `.mstack/design-research.md`, `power-analysis.md`, `survey-design.md`, `prereg/osf-prereg.md` |
   | Build | `data/raw/PROVENANCE.md`, `data/clean/analytic.rds`, `data/codebook.md` |
   | Analyze | `code/02-analyze.R`, `output/tables/*.tex`, `.mstack/results-audit-*.md`, `robustness-*.md`, `output/figures/*` |
   | Write | non-stub `paper/sections/*.tex|qmd`, `.mstack/referee-cache/*` |
   | Submit | `.mstack/journal-fit-*.md`, `submission/cover-letter.md`, `submission/response-to-reviewers/*` |
   | Reflect | `.mstack/retro.md`, `replication-manifest.txt` |

4. **Staleness.** A verdict is stale when its inputs changed after it was written (a results audit older than `code/02-analyze.R`; an identification review older than `methods.tex`). Compare modification times; flag each stale verdict for a re-run.
5. **Reconcile `paper.status`** with the furthest stage that has substantive output; if they disagree, say so and offer to update the field.
6. **Recommend exactly one next step:** the earliest gap in the pipeline wins over a shinier later stage. Name the skill and the reason in one sentence.

## Outputs

- A printed report: config summary, per-stage table (artifact · present · date · verdict), stale flags, the one next skill. No files written.
- With consent only: `paper.status` corrected in `.mstack/config.yaml`.

## Anti-patterns

- **Guessing the stage from the conversation.** The artifacts on disk are the record.
- **Three next steps.** One; the pipeline is ordered for a reason.
- **A stub counted as done.** A placeholder comment in `sections/theory.tex` is not a theory section.
