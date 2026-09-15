---
name: data-clean
description: Writes the reproducible raw-to-clean pipeline in code/01-clean.R — every join, drop, and recode logged with row-count checks — producing data/clean/analytic.rds. Use when the user needs to clean, merge, or recode data, build the analytic dataset, or fix a data issue (raw files are never edited).
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# /mstack:data-clean

**Stage:** build · **Voice:** data-engineer

After `/mstack:data-acquire`; before any analysis; re-run whenever the analytic dataset changes.

## Procedure

1. **Read `data/raw/PROVENANCE.md`.** If missing, stop and send the user to `/mstack:data-acquire`; undocumented raw data is not cleanable.
2. **R conventions:** the `r-coding-skills` skill if the user has it installed, else `${CLAUDE_PLUGIN_ROOT}/references/r-conventions.md`. Either way: tidyverse style, `here::here()` paths, snake_case, no `setwd()`, package versions noted.
3. **Plan in chat before coding:** reads (which raw files); joins (key, type, expected rows); recodes (variable, mapping); drops (rule, expected rows, justification); derived variables (formula); final analytic unit (country-year, individual-wave); outputs. Get confirmation. Apply any conventions already in `.mstack/learnings.jsonl` automatically and say which.
4. **Write `code/01-clean.R`:** header (purpose, inputs, outputs, run order); `library()` calls grouped at top; one block per step with a one-line comment; **every drop and join logged with `nrow()` before / after** plus a stop-if-unexpected check (`stopifnot(nrow(df) == expected)`); save to `data/clean/` as `.rds` with a `.csv` mirror for portability; dump `sessionInfo()` to `data/clean/session-info.txt`.
5. **Run** `Rscript code/01-clean.R`; capture output; fix and re-run until it exits clean.
6. **Sanity checks:** row counts match the plan; no fully-missing columns; key variables in expected ranges; unit of analysis unique (`stopifnot(!anyDuplicated(df[, key_cols]))`); `summary()` and a head / tail snapshot to `data/clean/clean-log.md`.

## Outputs

- `code/01-clean.R` — the canonical location; do not write the pipeline elsewhere.
- `data/clean/analytic.rds` (+ `.csv`), `data/clean/session-info.txt`, `data/clean/clean-log.md`.

## Anti-patterns

- **Editing `data/raw/`.** The guard hook denies it; a fix to raw is a recode in the script.
- **Silent drops.** Every drop has a row-count check.
- **Absolute paths.** `here::here()`.
- **Mixed-purpose scripts.** `01-clean.R` cleans; modeling is `02-analyze.R`.
- **Done with warnings.** R warnings are signal; address each or suppress with a justifying comment.

## Next

`/mstack:codebook`, then `/mstack:analyze`.
