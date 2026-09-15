---
name: data-clean
description: Writes the reproducible raw-to-clean pipeline in code/01-clean.R — sentinel recodes first, versioned crosswalks for every identifier merge, every join and drop logged with row-count and uniqueness assertions, lags computed within unit, state-existence and unit-boundary changes handled — producing data/clean/analytic.rds. Use when the user needs to clean, merge, or recode data, build the analytic dataset, or fix a data issue (raw files are never edited).
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

After `/mstack:data-acquire`; before any analysis; re-run whenever the analytic dataset changes. Most retracted or corrected quantitative papers trace to this script (a duplicated merge, a lag across a gap, a sentinel code treated as a number), so the pipeline is written to prove its own correctness at every step.

## Procedure

1. **Read `data/raw/PROVENANCE.md`.** If missing, stop and send the user to `/mstack:data-acquire`; undocumented raw data is not cleanable. Then read the harmonization checklist and the sentinel-code list in `${CLAUDE_PLUGIN_ROOT}/references/polisci-data-sources.md`.
2. **R conventions:** the `r-coding-skills` skill if the user has it installed, else `${CLAUDE_PLUGIN_ROOT}/references/r-conventions.md`. Either way: tidyverse style, `here::here()` paths, snake_case, no `setwd()`, package versions noted.
3. **Plan in chat before coding:** reads (which raw files, which vintages); sentinel recodes per source; identifier harmonization (which crosswalk, which target scheme, which NUTS or FIPS version); joins (key, type, expected rows, and why it is not many-to-many); recodes (variable, mapping); drops (rule, expected rows, justification); derived variables (formula; lags and leads within unit); state-existence and boundary-change handling; final analytic unit (country-year, region-election, respondent-task); outputs. Get confirmation. Apply any conventions already in `.mstack/learnings.jsonl` automatically and say which.
4. **Write `code/01-clean.R`:** header (purpose, inputs with vintages, outputs, run order); `library()` calls grouped at top; one block per step with a one-line comment; **sentinel values recoded to `NA` first**, with the codes listed; **every join asserts its expected row count and its relationship** (`relationship = "many-to-one"` and the like), and **unit-year uniqueness is asserted after every join** (`stopifnot(!anyDuplicated(df[, key_cols]))`); **every drop logged with `nrow()` before and after** plus a stop-if-unexpected check; lags and leads computed after `group_by(unit)` and `arrange(time)` with a gap assertion (`lag(year) == year - 1`); rows exist only for unit-years the unit existed; aggregation weights stated; labels preserved (`labelled::var_label()`); the original variable names kept in a crosswalk comment; save to `data/clean/` as `.rds` with a `.csv` mirror for portability; dump `sessionInfo()` to `data/clean/session-info.txt`.
5. **Run** `Rscript code/01-clean.R`; capture output; fix and re-run until it exits clean.
6. **Sanity checks:** row counts match the plan; no fully-missing columns; key variables in expected ranges with no sentinel values left; unit of analysis unique; the treatment has variation where the design needs it (share of units with within-variation for fixed-effects designs); `summary()`, a head / tail snapshot, and a time-series-by-unit figure of the treatment and outcome to `data/clean/clean-log.md` and `output/figures/clean-check-*.png`; unmatched keys from every merge listed in the log (an anti-join per join).
7. **Log decisions.** Every non-obvious cleaning call (a dropped period, a winsorizing cut, a crosswalk exception) goes to `decisions:` in `.mstack/config.yaml` with the date.

## Outputs

- `code/01-clean.R` — the canonical location; do not write the pipeline elsewhere.
- `data/clean/analytic.rds` (+ `.csv`), `data/clean/session-info.txt`, `data/clean/clean-log.md`, `output/figures/clean-check-*.png`.

## Anti-patterns

- **Editing `data/raw/`.** The guard hook denies it; a fix to raw is a recode in the script.
- **Merging on names.** Crosswalks and codes only, with unmatched keys listed.
- **Silent drops or duplicates.** Every drop has a row-count check; every join has a uniqueness check.
- **Lags without grouping and ordering.** The classic silent bug.
- **Absolute paths.** `here::here()`.
- **Mixed-purpose scripts.** `01-clean.R` cleans; modeling is `02-analyze.R`.
- **Done with warnings.** R warnings are signal; address each or suppress with a justifying comment.

## Next

`/mstack:codebook`, then `/mstack:analyze`.
