---
name: codebook
description: Auto-generates data/codebook.md from the analytic dataset — per-variable stats plus flags for missingness, near-constants, duplicates, and implausible values. Use after cleaning stabilizes, when the user asks to document variables, or before analysis.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
---

# /mstack:codebook

**Stage:** build · **Voice:** data-engineer

After `/mstack:data-clean` runs without errors; re-run whenever `data/clean/analytic.rds` changes.

## Procedure

1. **Load** `code/01-clean.R` to know what the variables are meant to be.
2. **Generate.** Copy `${CLAUDE_PLUGIN_ROOT}/skills/codebook/scripts/00-codebook.R` to `code/00-codebook.R`, set `KEY_COLS` and `UNIT` in its PARAMETERS block, and run `Rscript code/00-codebook.R`. It is idempotent and reports per variable: name; label (from `01-clean.R` comments or attr, flagged if missing); type; range or levels; mean / SD / median / IQR, or mode + frequency; missingness (count + share); source (from `data/raw/PROVENANCE.md`).
3. **Flags** it raises, plus any you notice: > 30% missing (document imputation or exclude); mass at an extreme (a winsorized cap); pairs with |r| > 0.99 (apparent duplicates); near-constants (< 5% variation); implausible dates (future, pre-source); rows not unique on the key.
4. `data/codebook.md` carries a header (dataset, N, K, unit, generation date, source script), the per-variable table, and a flag block with a recommended action per flag.
5. **Print the flags** with recommendations. Never accept them silently.

## Outputs

- `code/00-codebook.R` — idempotent generator; `data/codebook.md`.
- Summary block: variable count, missingness extremes, flag count + verdict.

## Anti-patterns

- **A codebook without flags.** Even clean data has something worth surfacing.
- **A hand-maintained codebook.** It rots; generate it.

## Next

`/mstack:analyze`; if flags are unaddressed, fix `01-clean.R` first.
