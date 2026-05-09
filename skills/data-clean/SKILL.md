---
name: data-clean
description: Reproducible cleaning pipeline. Reads from data/raw/, writes to data/clean/. Wraps the r-coding-skills skill for R conventions. Every drop, recode, and merge is logged with row-count checks.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# /mstack:data-clean

**Stage:** build
**Voice:** data-engineer (anchored to `r-coding-skills`)

## When to invoke

After `/data-acquire` has populated `data/raw/` and the provenance log. Run before any analysis. Re-run when the analytic dataset changes.

## Procedure

1. **Read the provenance log** at `data/raw/PROVENANCE.md` (or whatever `/data-acquire` wrote). If missing, stop and tell the user to run `/data-acquire` first — undocumented raw data is not cleanable.

2. **Invoke the r-coding-skills skill** for R conventions: tidyverse style, `here::here()` paths, named pipes, snake_case, no `setwd()`, package versioning notes.

3. **Plan the pipeline.** Before writing code, list (in chat) the cleaning steps:
   - Reads (which raw files).
   - Joins (key, type, expected row count).
   - Recodes (variable, mapping).
   - Drops (rule, expected row count, justification).
   - Derived variables (formula).
   - Final analytic unit (e.g., country-year, individual-wave).
   - Output file(s).

   Get user confirmation on the plan before writing code. If `.mstack/learnings.jsonl` already specifies conventions (variable names, exclusions), apply them automatically and note which.

4. **Write `code/01-clean.R`.** Conventions:
   - Header comment block: purpose, inputs, outputs, run order.
   - `library()` calls grouped at top.
   - Each step in its own block, preceded by a one-line comment.
   - **Every drop and join logged with `nrow()` before/after** and a stop-if-unexpected check (e.g., `stopifnot(nrow(df) == expected)`).
   - Save final dataset(s) to `data/clean/` as `.rds` (preferred) plus a `.csv` mirror for portability.
   - Save a session-info dump to `data/clean/session-info.txt` for replication.

5. **Run the script** with `Rscript code/01-clean.R`. Capture stdout/stderr. If it errors, fix and re-run; do not declare done with errors outstanding.

6. **Sanity checks** on the cleaned dataset:
   - Row counts match the plan.
   - No fully-missing columns.
   - Key variables in expected ranges.
   - Unit of analysis is unique (`stopifnot(!anyDuplicated(df[, key_cols]))`).
   - Print a `summary()` and a head/tail snapshot to a log file at `data/clean/clean-log.md`.

7. **Suggest the next step:** `/codebook` to auto-document the cleaned dataset.

## Outputs

- `code/01-clean.R` — the pipeline (canonical location; do not write to other paths).
- `data/clean/analytic.rds` (and `.csv` mirror) — the cleaned dataset.
- `data/clean/session-info.txt` — `sessionInfo()` dump for replication.
- `data/clean/clean-log.md` — row counts at each step, sanity-check output.

## Anti-patterns to refuse

- **Editing `data/raw/`.** Raw is read-only forever. If a fix to raw is needed, document it as a recode in the cleaning script, not as an edit to the file.
- **Silent drops.** Every drop is logged with a row-count check.
- **Hardcoded absolute paths.** Use `here::here()`.
- **Mixed-purpose scripts.** `01-clean.R` cleans. Modeling goes in `02-analyze.R`. Don't mix.
- **Done with warnings.** R warnings are signal. Address each or suppress with a justification comment.

## When to call other skills

- Before: `/data-acquire` (must produce `data/raw/PROVENANCE.md` first).
- After: `/codebook` to auto-document; then `/analyze` to model.
