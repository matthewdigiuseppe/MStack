---
name: analyze
description: Runs the primary specification and pre-specified secondaries in code/02-analyze.R and renders modelsummary tables in code/04-tables.R; the preregistration, if any, is the contract. Use when the user asks to run the models, estimate the main results, or produce regression tables.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# /mstack:analyze

**Stage:** analyze · **Voice:** analyst

After `/mstack:data-clean`, `/mstack:codebook`, and `/mstack:identification-review`. If preregistered (`/mstack:preregister`), the primary analysis in `prereg/osf-prereg.md` is the contract this skill executes.

## Procedure

1. **Load** `.mstack/config.yaml` (`stats.primary_spec`), `prereg/osf-prereg.md` if it exists, `.mstack/identification-review-*.md` (the identifying assumption), `.mstack/learnings.jsonl` (variable names, conventions), `data/clean/analytic.rds`, `data/codebook.md`.
2. **Confirm the spec** with the user before coding: outcome, treatment / IV, controls; fixed effects (which dimensions, why); SE clustering justified by the dependence structure; sample restrictions (matching the prereg if any); packages (default `fixest::feols` for OLS / FE, `marginaleffects` for AMEs, `modelsummary` for tables).
3. **R conventions:** `r-coding-skills` if installed, else `${CLAUDE_PLUGIN_ROOT}/references/r-conventions.md`.
4. **Write `code/02-analyze.R`:** header (purpose, inputs, outputs, run order, prereg link); load the clean data, never re-clean; fit the primary first as `m_primary`, pre-specified secondaries as `m_<descriptor>`; save model objects to `output/models/*.rds` for `03-figures.R` and `04-tables.R`; one-line summary per model to `output/analyze-log.md`.
5. **Write `code/04-tables.R`:** Table 1 descriptives for the analytic sample; Table 2 the primary specification (the table the paper is built around); Table 3+ secondaries. `modelsummary::modelsummary(output = "latex")` to `output/tables/*.tex`, which the manuscript `\input`s. Coefficient + 95% CI; stars only if the journal demands them.
6. **Run** `Rscript code/02-analyze.R && Rscript code/04-tables.R`; do not declare done with errors outstanding.
7. **Sanity check:** N matches the analytic dataset or a documented exclusion; the headline coefficient's sign matches H1, or flag it loudly before anyone drafts `results`; SEs clustered as specified.
8. **Hand-off.** Set `paper.status: "analyzing"` in `.mstack/config.yaml`. Do not run `/mstack:robustness` until the primary table is locked.

## Outputs

- `code/02-analyze.R`, `code/04-tables.R`.
- `output/models/m_primary.rds`, `output/models/m_<secondary>.rds`.
- `output/tables/table-1-descriptives.tex`, `table-2-primary.tex`, …
- `output/analyze-log.md` — one line per model.

## Anti-patterns

- **Unflagged off-prereg specs.** Exploratory specs go in `code/02b-exploratory.R` and are labeled exploratory in the paper.
- **Hand-rolled tables.** `modelsummary`, so reproduction is one command away.
- **P-value chasing.** If the primary spec does not give the headline, the headline changes; do not re-spec until it does.
- **Mixed clustering across tables** without justification.

## Next

`/mstack:results-audit` (mandatory before drafting), then `/mstack:robustness`, `/mstack:viz`, `/mstack:draft-section results`.
