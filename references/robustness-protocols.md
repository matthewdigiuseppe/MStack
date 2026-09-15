# Robustness protocols

Read by `/mstack:robustness` (what to vary and how to report it),
`/mstack:results-audit` (whether it was done honestly), and
`/mstack:preregister` (what to pre-commit). Design-specific sensitivity tools
are listed at the end of `identification-threats.md`.

## Three different questions

Robustness is not one exercise. Each question below has its own method, and
a paper that answers only the first has not addressed the other two.

1. **Is the headline an artifact of an arbitrary choice?** Specification
   curve over the defensible choices (Simonsohn, Simmons & Nelson 2020; Young
   & Holsteen 2017 on model uncertainty).
2. **Would a plausible unobserved confounder, or a plausible violation of the
   design's assumption, undo it?** Sensitivity analysis: `sensemakr`
   robustness values for selection on observables (Cinelli & Hazlett 2020),
   Oster (2019) coefficient stability with its assumptions stated,
   `HonestDiD` for parallel trends (Rambachan & Roth 2023), plausibly-
   exogenous intervals for IV (Conley, Hansen & Rossi 2012), bandwidth and
   donut sensitivity for RD.
3. **Is it carried by a few units, periods, or observations?** Influence
   analysis: leave-one-unit-out and leave-one-period-out estimates plotted;
   Cook's distance and dfbetas for small cross-sections; winsorized and
   trimmed versions, with the cut chosen before looking.

Checks pre-committed in the preregistration are confirmatory; everything
else is exploratory and labeled so in the paper.

## The choice inventory

For the primary specification, enumerate every researcher degree of freedom.
Sort each alternative into one of three bins before running anything:

- **Substantive alternatives** (a different operationalization of the
  outcome, a different comparison group, a different treatment threshold):
  run and report, including the ones that hurt.
- **Arbitrary alternatives** (bandwidth, lag length, winsorizing cut,
  polynomial order, sample window edges): vary over a grid and show the
  whole grid.
- **Indefensible alternatives** (dropping the control the theory requires,
  conditioning on a post-treatment variable, an estimator known to be
  biased for the design): not robustness checks but misspecifications; do
  not run them as "alternatives" and do not report them as reassurance.

Dimensions to inventory: sample restrictions, outcome operationalization,
treatment operationalization, control set, fixed-effect structure,
clustering level, functional form (levels, logs, shares), composition
(outliers, subgroups, unit sets), time window, estimator (OLS, PPML, LPM,
logit, staggered-DiD estimators), weights.

## Specification curve

- Write the inclusion rule before running: only specifications you would
  have defended ex ante. A curve padded with junk specifications proves
  nothing either way.
- Plot the estimates with confidence intervals ranked by size, the primary
  marked, and a dashboard panel beneath showing which choice each
  specification makes on each dimension (`specr` does this; the bundled
  `spec-curve.R` draws the ranked panel).
- Summarize the share sharing the primary's sign, the share with intervals
  excluding zero, and the median estimate; add a joint inferential test if
  the paper leans on the curve (Simonsohn et al. 2020 describe bootstrap
  tests under the null of no effect).
- The bundled `summarize_robustness()` verdict thresholds (Stable > 80%
  agreement in sign and significance, Sensitive 40–80%, Fragile < 40%) are
  descriptive conventions, not tests; say so.

## Sensitivity to unobservables, reported as a sentence

The reader needs one sentence per headline estimate:

- Selection on observables: "An unobserved confounder would need to explain
  at least X% of the residual variance of both treatment and outcome (RV),
  Y times the strength of [strongest observed covariate], to bring the
  estimate to zero" (`sensemakr::sensemakr()` with `benchmark_covariates`).
- DiD: "The estimate remains positive for post-treatment violations of
  parallel trends up to M̄ = ..., i.e. deviations up to ... times the largest
  pre-period deviation" (`HonestDiD`).
- IV: the range of direct effects of the instrument on the outcome under
  which the conclusion survives.
- RD: the bandwidths and polynomial orders over which the conclusion holds.

## Placebos and negative controls

- Placebo outcomes: something the treatment cannot move by the theory but
  that shares the confounding structure; the estimate should be zero.
- Placebo treatments or timings: false treatment dates, false thresholds,
  reassigned exposure.
- Negative-control exposures: a variable with the treatment's confounding
  structure and no causal channel.
- Report placebos with the same precision as the headline; a placebo with a
  wide interval around zero is weak evidence.

## Alternative inference

More aggregated clustering; the wild cluster bootstrap when clusters are
few; randomization inference for experiments and quasi-random assignment;
permutation of the treatment across units for designs where assignment is
"as if" random. Report the most conservative alongside the primary.

## Heterogeneity is not robustness

Pre-specified moderators only, reported as marginal effects at each level
with intervals and common support shown. Subgroup results that were not
pre-specified are exploratory and sit in the appendix labeled as such;
finding the subgroup where the effect appears is the forking path the
protocol exists to prevent.

## Reporting

- Appendix: one table of alternatives against the primary, one
  specification-curve figure, one sensitivity figure or table, the influence
  plots.
- Main text: one paragraph stating which checks were pre-committed, how many
  alternatives were run, what share agree with the primary, and the
  sensitivity sentence. If the result is Sensitive or Fragile, the main text
  says so and the headline is rewritten as conditional; hiding fragility in
  an appendix is the failure this skill exists to prevent.
