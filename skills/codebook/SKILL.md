---
name: codebook
description: Auto-generates a codebook from the cleaned analytic dataset and flags suspicious distributions. Writes data/codebook.md. Use after /data-clean produces a stable analytic dataset.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
---

# /mstack:codebook

**Stage:** build
**Voice:** data-engineer

## When to invoke

After `/data-clean` writes `data/clean/analytic.rds` and the script runs without errors. Re-run when the analytic dataset changes.

## Procedure

1. **Load.** `data/clean/analytic.rds`. Read `code/01-clean.R` to know what the variables are supposed to mean.

2. **Generate the codebook** via R. Write a one-off script `code/00-codebook.R` (idempotent — safe to re-run):

   For each variable:
   - **Name.**
   - **Label** (from `01-clean.R` comments or attr; if missing, flag).
   - **Type** (numeric, factor, logical, date, character).
   - **Range** (min/max for numeric, levels for factor).
   - **Mean / SD / Median / IQR** (numeric).
   - **Modal value + frequency** (factor / categorical).
   - **Missingness** (count + share).
   - **Source** (from `data/raw/PROVENANCE.md`).

3. **Flag suspicious patterns** for the user:
   - Variables with > 30% missingness — flag for either documented imputation or exclusion.
   - Numeric variables with mass at the extreme (e.g., all values at the cap of a winsorized scale).
   - Apparent duplicates: pairs of variables with > 0.99 correlation.
   - Near-constant variables (< 5% variation).
   - Date variables with implausible values (future dates, pre-data-source dates).
   - Unit-of-analysis ambiguities (rows that should be unique by `id` but aren't).

4. **Write `data/codebook.md`** with:
   - Header: dataset name, N, K, unit of analysis, generation date, source script.
   - Per-variable table.
   - Flag block at the bottom listing every suspicious pattern with a recommended action.

5. **If flags exist:** print them to the user with a recommendation. Do **not** silently accept them.

## Outputs

- `code/00-codebook.R` — idempotent generation script.
- `data/codebook.md` — the codebook.
- Summary block: variable count, missingness extremes, suspicious-pattern flag count + verdict.

## Anti-patterns to refuse

- **Codebook without flags.** Even clean datasets have something worth surfacing.
- **Manually maintained codebook.** It rots. Generate from the data.

## When to call other skills

- After: `/analyze`. If flags are unaddressed, suggest fixing `01-clean.R` first.
