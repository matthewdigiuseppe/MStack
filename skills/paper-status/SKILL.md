---
name: paper-status
description: Reads the paper folder's .mstack/ memory and pipeline outputs and reports where the project stands — stage, artifacts present or missing, stale verdicts, and the single recommended next MStack skill. Use when the user asks where they left off, what's next, or for a status check — and at the start of a session on an existing paper.
allowed-tools:
  - Read
  - Grep
  - Glob
  - Edit
---

# /mstack:paper-status

**Stage:** power (any time)
**Voice:** project-manager

## When to invoke

Opening a session on an existing paper. Returning after a gap. Whenever the user asks "where were we?", "what's next?", or which skill to run. This skill is read-only apart from an offered `paper.status` correction.

## Procedure

1. **Locate the paper folder.** Find `.mstack/` in the current directory or an ancestor. If none exists, say so and suggest `/mstack:mstack-init`.

2. **Read `.mstack/config.yaml`** — title, `paper.status`, format, `design.prereg`, target journals.

3. **Inventory the pipeline.** For each stage, check its artifacts and pull the verdict line (grep for `Verdict`) plus the file date:

   | Stage | Artifacts to check |
   |---|---|
   | Ideate | `.mstack/research-question.md`, `idea-shotgun-*.md`, `scope-challenge-*.md` |
   | Map | `.mstack/lit-map.md`, `theory.md`, `hypotheses.md`, `identification-review-*.md` |
   | Design | `.mstack/design-research.md`, `power-analysis.md`, `survey-design.md`, `prereg/osf-prereg.md` |
   | Build | `data/raw/PROVENANCE.md`, `data/clean/analytic.rds`, `data/codebook.md` |
   | Analyze | `code/02-analyze.R`, `output/tables/*.tex`, `.mstack/results-audit-*.md`, `robustness-*.md`, `output/figures/*` |
   | Write | non-stub `paper/sections/*.tex|qmd`, `.mstack/referee-cache/*` |
   | Submit | `.mstack/journal-fit-*.md`, `submission/cover-letter.md`, `submission/response-to-reviewers/*` |
   | Reflect | `.mstack/retro.md`, `replication-manifest.txt` |

4. **Flag staleness.** A verdict is stale when its inputs changed after it was written — e.g. a results-audit older than `code/02-analyze.R`, or an identification review older than `methods.tex`. Compare file modification times and flag each stale verdict for a re-run.

5. **Reconcile `paper.status`.** Derive the stage from the artifacts (the furthest stage with substantive output). If it disagrees with `paper.status` in config, say so and offer to update the field.

6. **Recommend exactly one next step.** The earliest gap in the pipeline wins: a missing prerequisite beats a shiny later stage. Name the skill (`/mstack:...`) and the reason in one sentence.

## Outputs

- A printed status report: config summary, per-stage table (artifact · present · date · verdict), stale flags, and the one recommended next skill. No files are written.
- (Only with user consent) `paper.status` corrected in `.mstack/config.yaml`.

## Anti-patterns to refuse

- **Guessing the stage from the conversation.** The artifacts on disk are the record; check them.
- **Recommending three next steps.** One. The pipeline is ordered for a reason.
- **Treating a stub as done.** A `sections/theory.tex` containing a placeholder comment is not a drafted theory section.

## When to call other skills

- Whatever this skill recommends — that is its whole job.
