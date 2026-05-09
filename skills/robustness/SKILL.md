---
name: robustness
description: Builds a robustness matrix — alternative specifications, samples, and operationalizations. Fights the cherry-picking / forking-paths problem. Run after /analyze + /results-audit, before /draft-section results.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
---

# /mstack:robustness

**Stage:** analyze
**Voice:** skeptical-analyst (anchored to `r-coding-skills`)

## When to invoke

After `/analyze` produces a primary table and `/results-audit` passes. Robustness is not "more tables for the appendix" — it's the test of whether the headline is fragile.

## Procedure

1. **Load.** `code/02-analyze.R`, `output/models/`, `prereg/osf-prereg.md` (which lists pre-committed robustness checks), `.mstack/identification-review-*.md`.

2. **Enumerate the design choices** in the primary spec. For each choice, list at least one defensible alternative:

   | Choice in primary | Alternative(s) |
   |---|---|
   | Sample restriction | Drop the most restrictive cut; add a stricter cut |
   | Outcome operationalization | Alternative scaling, alternative scoring, dichotomized vs. continuous |
   | Treatment operationalization | Continuous vs. binary, alternative threshold, lagged treatment |
   | Fixed-effects structure | Drop a dimension, add a dimension, swap to interactive FE |
   | Standard-error clustering | Alternative cluster level (more / less aggregated) |
   | Functional form | Linear vs. log, polynomial, splines |
   | Sample composition | With / without outliers, with / without specific subgroups |
   | Time window | Earlier / later cutoffs |

3. **Write `code/05-robustness.R`** that:
   - Loads `data/clean/analytic.rds` (do not re-clean).
   - Defines the primary spec as a function or formula object.
   - Iterates over the alternatives, fitting each model.
   - Stores results in a long data frame: `(spec_name, dimension, value, coef, se, ci_low, ci_high, n)`.
   - Saves the result as `output/models/robustness.rds`.

4. **Write `code/06-robustness-table-and-curve.R`** that:
   - Renders a **robustness table** at `output/tables/table-robustness.tex` showing each alternative against the primary.
   - Renders a **specification curve** at `output/figures/specification-curve.pdf` plotting all coefficients with CIs ranked by magnitude, with the primary spec marked.

5. **Verdict.** Inspect the curve:
   - **Stable** — > 80% of reasonable alternatives agree in sign and significance with the primary. Headline survives.
   - **Sensitive** — sign flips or significance disappears in a meaningful fraction of alternatives. The headline must be qualified or the spec rejustified.
   - **Fragile** — only the primary survives. The paper's findings are conditional on a single specification. Recommend rewriting the headline as conditional, or switching to a more conservative primary.

6. **Save** to `.mstack/robustness-<YYYY-MM-DD>.md` with the verdict and a one-paragraph interpretation.

## Outputs

- `code/05-robustness.R`, `code/06-robustness-table-and-curve.R`.
- `output/models/robustness.rds`.
- `output/tables/table-robustness.tex`.
- `output/figures/specification-curve.pdf`.
- `.mstack/robustness-<date>.md` — verdict.
- Summary block: count of specs run, share agreeing with primary, verdict.

## Anti-patterns to refuse

- **Cherry-picking robustness checks.** Show the alternatives that *could* break the result, not just the ones that don't.
- **Hiding fragility in an appendix.** If the result is fragile, the main paper says so.
- **Adding robustness tests until one supports the primary.** This is forking paths in disguise.

## When to call other skills

- Before: `/results-audit` must pass.
- After: `/viz` (specification curve is one of the figures), then `/draft-section results`.
