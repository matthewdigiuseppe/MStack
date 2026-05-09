---
name: analyze
description: Runs the primary specification(s) and produces regression tables. Writes to code/02-analyze.R and code/04-tables.R, output to output/tables/. Defers to r-coding-skills for R conventions and to the preregistration for the primary spec.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# /mstack:analyze

**Stage:** analyze
**Voice:** analyst (anchored to `r-coding-skills`)

## When to invoke

After `/data-clean` produces a stable analytic dataset and `/codebook` has flagged any data issues. If the project is preregistered, the primary spec is in `prereg/osf-prereg.md` — this skill executes it.

## Procedure

1. **Load context.**
   - `.mstack/config.yaml` for primary spec (the one-line description).
   - `prereg/osf-prereg.md` if it exists — the primary analysis section is the contract.
   - `.mstack/identification-review-*.md` for the identifying assumption.
   - `.mstack/learnings.jsonl` for variable names and conventions.
   - `data/clean/analytic.rds` and `data/codebook.md`.

2. **Confirm the spec** with the user before writing code:
   - Outcome variable, treatment / IV, controls.
   - Fixed effects (which dimensions, why).
   - SE clustering (which level, justified by the dependence structure).
   - Sample restrictions (must match prereg if preregistered).
   - Software / package (default: `fixest::feols` for OLS / FE; `marginaleffects` for AMEs; `modelsummary` for tables).

3. **Invoke r-coding-skills** for style conventions.

4. **Write `code/02-analyze.R`.**
   - Header: purpose, inputs, outputs, run order, link to prereg if applicable.
   - Load the cleaned dataset; do not re-clean.
   - Fit the primary model **first** and store it as `m_primary`.
   - Fit any pre-specified secondary models, named `m_<descriptor>`.
   - Save model objects to `output/models/` as `.rds` for reuse by `03-figures.R` and `04-tables.R`.
   - Print a one-line summary of each model to a log file at `output/analyze-log.md`.

5. **Write `code/04-tables.R`** to render `output/tables/`:
   - **Table 1** — descriptive statistics for the analytic sample.
   - **Table 2** — the primary specification (the table the paper is built around).
   - **Table 3+** — pre-specified secondaries.
   - Use `modelsummary::modelsummary()` with `output = "latex"`. Save `.tex` files; the manuscript `\input`s them.
   - Standard errors clustered as specified. Stars only if the journal demands them; default is coefficient + 95% CI.

6. **Run** `Rscript code/02-analyze.R && Rscript code/04-tables.R`. Capture errors. Do not declare done with errors.

7. **Sanity check** the tables:
   - N matches the analytic dataset (or matches a documented exclusion).
   - The headline coefficient sign matches H1 (or, if it doesn't, flag this loudly — the user needs to know before drafting `results`).
   - Standard errors clustered as specified.

8. **Hand-off.** Suggest `/results-audit` next. Do **not** run `/robustness` until the primary table is locked.

## Outputs

- `code/02-analyze.R`, `code/04-tables.R`.
- `output/models/m_primary.rds`, `output/models/m_<secondary>.rds`.
- `output/tables/table-1-descriptives.tex`, `output/tables/table-2-primary.tex`, etc.
- `output/analyze-log.md` — one-line summary per model.

## Anti-patterns to refuse

- **Running specs not in the prereg without flagging them.** If preregistered, exploratory specs go in a separate file (`code/02b-exploratory.R`) and are labeled exploratory in the paper.
- **Hand-rolled regression tables.** Use `modelsummary` so reproducibility is one command away.
- **P-value chasing.** If the primary spec doesn't give the headline, the paper's headline changes — do not retro-spec until it does.
- **Mixed clustering across tables.** SE structure should be consistent or the paper must justify the difference.

## When to call other skills

- Before: `/data-clean`, `/codebook`, `/identification-review`, `/preregister`.
- After: `/results-audit` (mandatory before drafting), then `/robustness`, then `/viz`, then `/draft-section results`.
