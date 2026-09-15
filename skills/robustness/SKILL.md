---
name: robustness
description: Stress-tests the headline in three ways — a specification curve over the defensible choices, sensitivity to unobserved confounding or to the design's assumption (sensemakr, HonestDiD, plausibly-exogenous IV, RD bandwidths), and influence of single units or periods — plus placebos and alternative inference, with a stable/sensitive/fragile verdict and the sensitivity sentence the paper must carry. Use after the primary table is locked, or when the user asks for robustness checks or worries about cherry-picking.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
---

# /mstack:robustness

**Stage:** analyze · **Voice:** skeptical-analyst

After `/mstack:analyze` and a passing `/mstack:results-audit`. Robustness is not more appendix tables; it answers three different questions about the headline, and a paper that answers only the first has not addressed the other two.

## Procedure

1. **Load** `code/02-analyze.R`, `output/models/`, `prereg/osf-prereg.md` (the pre-committed checks), `.mstack/identification-review-*.md` (the sensitivity analysis it named and the rival mechanisms), `.mstack/theory.md` (the rivals table), `.mstack/config.yaml` (`design.type`).
2. **Read** `${CLAUDE_PLUGIN_ROOT}/references/robustness-protocols.md` and the sensitivity tools at the end of `${CLAUDE_PLUGIN_ROOT}/references/identification-threats.md`.
3. **The choice inventory.** Enumerate every researcher degree of freedom in the primary spec and sort each alternative into a bin before running anything: **substantive** (a different operationalization, comparison group, or threshold; run and report even if it hurts), **arbitrary** (bandwidth, lag, winsorizing cut, window edges, polynomial order; vary over a grid), **indefensible** (dropping the control the theory requires, conditioning on a post-treatment variable, an estimator known to be biased for the design; not a robustness check, do not run it as one). Dimensions:

   | Choice | Alternatives |
   |---|---|
   | Sample restriction | Drop the most restrictive cut; add a stricter one |
   | Outcome operationalization | Alternative scaling or scoring; dichotomized vs. continuous; alternative source |
   | Treatment operationalization | Continuous vs. binary; alternative threshold; lagged treatment |
   | Control set | With and without the contestable controls; never a post-treatment one |
   | Fixed effects | Drop or add a dimension; interactive FE |
   | Clustering | More aggregated level; wild cluster bootstrap |
   | Functional form | Levels vs. logs vs. shares; PPML for flows |
   | Estimator | The design's heterogeneity-robust alternatives |
   | Composition | With / without outliers or specific subgroups; leave-one-unit-out |
   | Time window | Earlier / later cutoffs; leave-one-period-out |
   | Weights | Weighted vs. unweighted |

   Then add the rows of the rivals table as placebo and subgroup tests: each rival's observable implication becomes a specification whose result is predicted in advance.
4. **Write `code/05-robustness.R`:** load `data/clean/analytic.rds` (never re-clean); define the primary spec as a function; iterate over the substantive and arbitrary alternatives; store a long data frame `(spec_name, dimension, value, coef, se, ci_low, ci_high, n)` to `output/models/robustness.rds`; run the placebos and negative controls; run the sensitivity analysis for the design (`sensemakr` with benchmark covariates for selection on observables; `HonestDiD` for DiD; plausibly-exogenous intervals for IV; a bandwidth and donut grid for RD); run the influence analysis (leave-one-unit-out and leave-one-period-out); run the alternative inference (more aggregated clustering, wild cluster bootstrap, randomization inference for experiments).
5. **Write `code/06-robustness-table-and-curve.R`.** Copy `${CLAUDE_PLUGIN_ROOT}/skills/robustness/assets/spec-curve.R` to `code/spec-curve.R` and `source()` it for `plot_spec_curve()` and `summarize_robustness()`; `specr` may draw the dashboard panel. Render `output/tables/table-robustness.tex` (each alternative against the primary), `output/figures/specification-curve.pdf` (all coefficients with intervals ranked by magnitude, the primary marked, the inclusion rule in the caption), `output/figures/sensitivity.pdf` (the contour, breakdown, or bandwidth plot for the design), and `output/figures/influence.pdf` (leave-one-out estimates).
6. **Verdict** on the curve, stated as a descriptive convention: **Stable** (more than 80% of alternatives agree in sign and significance; the headline survives), **Sensitive** (sign flips or significance vanishes in a meaningful fraction; qualify the headline or rejustify the spec), **Fragile** (only the primary survives; rewrite the headline as conditional or switch to a more conservative primary). Report separately whether any placebo "worked", which single unit or period carries the estimate, and the sensitivity sentence.
7. **Save** to `.mstack/robustness-<YYYY-MM-DD>.md`: the inventory with bins, the verdict, the sensitivity sentence in the form the paper will use ("an unobserved confounder would need to be X times as strong as [covariate] to bring the estimate to zero"; "the estimate survives post-treatment violations of parallel trends up to M̄ = …"), the placebo results, the influential units, and a one-paragraph interpretation.

## Outputs

- `code/05-robustness.R`, `code/06-robustness-table-and-curve.R`, `code/spec-curve.R`.
- `output/models/robustness.rds`, `output/tables/table-robustness.tex`, `output/figures/specification-curve.pdf`, `output/figures/sensitivity.pdf`, `output/figures/influence.pdf`.
- `.mstack/robustness-<date>.md`.
- Summary block: specs run and share agreeing with the primary, the sensitivity sentence, placebo results, influential units, verdict.

## Anti-patterns

- **Cherry-picked checks.** Show the alternatives that could break the result, not just the ones that don't.
- **A curve padded with indefensible specifications.** Write the inclusion rule first.
- **Fragility hidden in an appendix.** A fragile result is stated in the main text.
- **Adding checks until one supports the primary.** Forking paths in disguise.
- **Heterogeneity as robustness.** Pre-specified moderators only; the subgroup where the effect appears is not a check.

## Next

`/mstack:viz` (the curve and the sensitivity plot are figures), then `/mstack:draft-section results`.
