---
name: analyze
description: Runs the primary specification and pre-specified secondaries in code/02-analyze.R with the estimator the design calls for (heterogeneity-robust DiD, rdrobust, weak-IV-robust IV, PPML for flows, Lin adjustment for experiments), standard errors at the assignment level, marginal effects for interactions and nonlinear models, and renders modelsummary tables in code/04-tables.R; the preregistration, if any, is the contract. Use when the user asks to run the models, estimate the main results, or produce regression tables.
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

After `/mstack:data-clean`, `/mstack:codebook`, and `/mstack:identification-review`. If preregistered (`/mstack:preregister`), the primary analysis in `prereg/osf-prereg.md` is the contract this skill executes; otherwise the specification confirmed with the user is written down before any model runs, so that what follows is not a search.

## Procedure

1. **Load** `.mstack/hypotheses.md` (the estimand for each hypothesis), `prereg/osf-prereg.md` if it exists, `.mstack/identification-review-*.md` (the assumption, the falsification tests, the sensitivity analysis), `.mstack/config.yaml` (`design.type`, `stats.primary_spec`), `.mstack/learnings.jsonl` (variable names, conventions), `data/clean/analytic.rds`, `data/codebook.md`.
2. **Read** the General section and the design section of `${CLAUDE_PLUGIN_ROOT}/references/estimation-conventions.md`.
3. **Confirm the spec** with the user before coding, or transcribe it from the prereg: estimand; outcome, treatment / IV, controls (each pre-treatment); the estimator the design calls for (`fixest::feols` with fixed effects for panels; `sunab`, `did`, or `didimputation` under staggered adoption; `rdrobust` for RD; IV with weak-instrument-robust intervals; PPML for flows with zeros; `lm_robust` with Lin adjustment for experiments; conjoint AMCEs with marginal means); fixed effects and why; standard errors clustered at the assignment level, with the wild cluster bootstrap when clusters are few; sample restrictions matching the prereg; `marginaleffects` for anything that is not the coefficient itself.
4. **R conventions:** `r-coding-skills` if installed, else `${CLAUDE_PLUGIN_ROOT}/references/r-conventions.md`.
5. **Write `code/02-analyze.R`:** header (purpose, inputs, outputs, run order, prereg link); load the clean data, never re-clean; fit the primary first as `m_primary`; then the falsification tests the identification review named (placebo outcomes, pre-trends, negative controls) as `m_placebo_*`; then pre-specified secondaries as `m_<descriptor>`; compute the estimand from each model with `marginaleffects` where the coefficient is not the quantity; save model objects to `output/models/*.rds` for `03-figures.R` and `04-tables.R`; one-line summary per model (estimate, interval, N, clusters, estimator) to `output/analyze-log.md`. Exploratory specifications go in `code/02b-exploratory.R`, never in this file.
6. **Write `code/04-tables.R`:** Table 1 descriptives for the analytic sample (by arm with a balance column for experiments); Table 2 the primary specification, the table the paper is built around; Table 3+ falsification tests and secondaries. `modelsummary::modelsummary(output = "latex")` to `output/tables/*.tex`, which the manuscript `\input`s; readable coefficient labels; notes stating the estimator, the standard-error type and cluster level, and what the coefficient is (a 1-SD change, an AME). Coefficient + 95% CI; stars only if the journal demands them.
7. **Run** `Rscript code/02-analyze.R && Rscript code/04-tables.R`; do not declare done with errors outstanding.
8. **Sanity check:** N matches the analytic dataset or a documented exclusion; the number of clusters is printed and adequate; for fixed-effects designs, the share of units with within-variation is printed; the headline's sign matches H1, or flag it loudly before anyone drafts `results`; the falsification tests behave (a placebo that "works" is a finding against the design); the substantive magnitude is stated in outcome units and as a share of the outcome SD.
9. **Hand-off.** Set `paper.status: "analyzing"` in `.mstack/config.yaml`. Do not run `/mstack:robustness` until the primary table is locked.

## Outputs

- `code/02-analyze.R`, `code/04-tables.R`, optional `code/02b-exploratory.R`.
- `output/models/m_primary.rds`, `m_placebo_*.rds`, `m_<secondary>.rds`.
- `output/tables/table-1-descriptives.tex`, `table-2-primary.tex`, `table-3-*.tex`.
- `output/analyze-log.md` — one line per model.

## Anti-patterns

- **Unflagged off-prereg specs.** Exploratory specs go in `code/02b-exploratory.R` and are labeled exploratory in the paper.
- **Two-way fixed effects under staggered adoption.** Use an estimator built for it.
- **A coefficient reported as the estimand when it is not.** Logit coefficients, interaction terms, and IV coefficients need the quantity computed.
- **Hand-rolled tables.** `modelsummary`, so reproduction is one command away.
- **P-value chasing.** If the primary spec does not give the headline, the headline changes; do not re-spec until it does.
- **Mixed clustering across tables** without justification.

## Next

`/mstack:results-audit` (mandatory before drafting), then `/mstack:robustness`, `/mstack:viz`, `/mstack:draft-section results`.
