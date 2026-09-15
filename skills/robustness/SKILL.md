---
name: robustness
description: Stress-tests the headline across alternative samples, operationalizations, fixed effects, clustering, and functional forms — robustness table, specification curve, stable/sensitive/fragile verdict. Use after the primary table is locked, or when the user asks for robustness checks or worries about cherry-picking.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
---

# /mstack:robustness

**Stage:** analyze · **Voice:** skeptical-analyst

After `/mstack:analyze` and a passing `/mstack:results-audit`. Robustness is not more appendix tables; it is the test of whether the headline is fragile.

## Procedure

1. **Load** `code/02-analyze.R`, `output/models/`, `prereg/osf-prereg.md` (pre-committed checks), `.mstack/identification-review-*.md`.
2. **Enumerate the design choices** in the primary spec, with at least one defensible alternative each:

   | Choice | Alternatives |
   |---|---|
   | Sample restriction | Drop the most restrictive cut; add a stricter one |
   | Outcome operationalization | Alternative scaling or scoring; dichotomized vs. continuous |
   | Treatment operationalization | Continuous vs. binary; alternative threshold; lagged treatment |
   | Fixed effects | Drop or add a dimension; interactive FE |
   | Clustering | More / less aggregated level |
   | Functional form | Linear vs. log; polynomial; splines |
   | Sample composition | With / without outliers or specific subgroups |
   | Time window | Earlier / later cutoffs |

3. **Write `code/05-robustness.R`** (R conventions: `r-coding-skills` if installed, else `${CLAUDE_PLUGIN_ROOT}/references/r-conventions.md`): load `data/clean/analytic.rds` (never re-clean); define the primary spec as a function or formula object; iterate over the alternatives; store a long data frame `(spec_name, dimension, value, coef, se, ci_low, ci_high, n)` to `output/models/robustness.rds`.
4. **Write `code/06-robustness-table-and-curve.R`.** Copy `${CLAUDE_PLUGIN_ROOT}/skills/robustness/assets/spec-curve.R` to `code/spec-curve.R` and `source()` it for `plot_spec_curve()` and `summarize_robustness()`. Render `output/tables/table-robustness.tex` (each alternative against the primary) and `output/figures/specification-curve.pdf` (all coefficients with CIs ranked by magnitude, the primary marked).
5. **Verdict:** **Stable** (> 80% of alternatives agree in sign and significance; the headline survives), **Sensitive** (sign flips or significance vanishes in a meaningful fraction; qualify the headline or rejustify the spec), **Fragile** (only the primary survives; rewrite the headline as conditional or switch to a more conservative primary).
6. **Save** to `.mstack/robustness-<YYYY-MM-DD>.md` with the verdict and a one-paragraph interpretation.

## Outputs

- `code/05-robustness.R`, `code/06-robustness-table-and-curve.R`, `code/spec-curve.R`.
- `output/models/robustness.rds`, `output/tables/table-robustness.tex`, `output/figures/specification-curve.pdf`.
- `.mstack/robustness-<date>.md`.
- Summary block: specs run, share agreeing with the primary, verdict.

## Anti-patterns

- **Cherry-picked checks.** Show the alternatives that could break the result, not just the ones that don't.
- **Fragility hidden in an appendix.** A fragile result is stated in the main text.
- **Adding checks until one supports the primary.** Forking paths in disguise.

## Next

`/mstack:viz` (the curve is one of the figures), then `/mstack:draft-section results`.
