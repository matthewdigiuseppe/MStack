# Estimation and reporting conventions, by design

Read by `/mstack:analyze` when writing `code/02-analyze.R` and `04-tables.R`,
and by `/mstack:results-audit` when checking them. The R style rules live in
`r-conventions.md` (or the user's `r-coding-skills`); this file is about what
to estimate and how to report it. Pick the section for the design; the
General section always applies.

## General

- **Estimate the estimand named in `.mstack/hypotheses.md`.** If the model's
  coefficient is not that quantity (a logit coefficient, an interaction term,
  a LATE), compute the quantity with `marginaleffects` and report it.
- **Primary specification first**, exactly as preregistered or as confirmed
  with the user, saved as `m_primary`. Every other model is named for what it
  changes (`m_no_controls`, `m_alt_cluster`, `m_logit`).
- **Standard errors** follow the assignment mechanism: cluster at the level
  of treatment assignment; use the wild cluster bootstrap below ~40 clusters
  (`fwildclusterboot`); dyadic-cluster-robust for dyads; Conley for spatial
  designs where distance matters. State the choice in a table note, once.
- **Report effect sizes in substantive units:** the change in the outcome
  for a one-standard-deviation or one-policy-relevant change in treatment,
  as a share of the outcome's standard deviation or baseline mean. Never
  only "significant".
- **Confidence intervals, not stars.** 95% intervals in tables and in prose;
  `modelsummary(stars = FALSE)` unless the journal insists.
- **Interactions.** Report marginal effects of X at meaningful values of the
  moderator with confidence intervals, not the interaction coefficient
  alone (Brambor, Clark & Golder 2006), and check common support and
  linearity in the moderator with a binning or kernel estimator
  (Hainmueller, Mummolo & Xu 2019; `interflex`).
- **Binary outcomes.** A linear probability model is fine for average
  effects with fixed effects; if a logit or probit is used, report average
  marginal effects, never raw coefficients, and never compare coefficients
  across models or samples (Mood 2010).
- **Logs.** `log(1 + y)` distorts effects near zero and depends on units
  (Chen & Roth 2024); prefer PPML for counts and flows with zeros, or the
  inverse hyperbolic sine with the caveat stated, and report the elasticity
  the reader cares about.
- **Missing data.** Listwise deletion changes the sample; report N per model
  and, when covariate missingness is non-trivial, multiple imputation with
  the imputation model described.
- **Weights.** Survey weights for descriptive estimands about a population;
  for causal contrasts within a sample, unweighted estimates with weights as
  a robustness check (Solon, Haider & Wooldridge 2015).
- **Descriptives table** (Table 1): analytic sample, with N, mean, SD, min,
  max per variable; for experiments, by arm with a balance column.

## Randomized experiments

- ITT as the primary estimand; CACE via IV with assignment as the instrument
  when compliance is partial and exclusion holds.
- Covariate adjustment only as preregistered, using Lin (2013) full
  interaction or `estimatr::lm_lin`; `lm_robust` with HC2 by default;
  cluster by the randomization cluster.
- Conjoints: AMCEs via `cregg` or `cjoint` with clustering by respondent;
  marginal means for subgroup comparisons.
- Randomization inference for the sharp null as a robustness check (`ri2`).
- Attrition: report by arm; bounds if differential.

## Difference-in-differences and event studies

- Never a plain two-way fixed-effects coefficient as the headline under
  staggered adoption. `fixest::sunab()` (Sun & Abraham), `did::att_gt()`
  with `aggte()` (Callaway & Sant'Anna), or `didimputation` (Borusyak,
  Jaravel & Spiess). Report the overall ATT and the event-time profile.
- Event-study figure with pre-period coefficients and the reference period
  marked; the joint pre-trend test in a note, with the Roth (2022) caveat.
- `HonestDiD` sensitivity reported for the headline.
- Cluster at the unit of treatment assignment (state, region).

## Regression discontinuity

- `rdrobust` with MSE-optimal bandwidth and robust bias-corrected intervals;
  report the conventional and robust estimates, the bandwidth, and the
  effective N on each side.
- `rddensity` manipulation test, covariate continuity, placebo cutoffs, and
  a bandwidth sensitivity plot in the appendix.
- Fuzzy RD via `rdrobust(fuzzy = )`; report the first stage at the cutoff.

## Instrumental variables

- `fixest::feols(y ~ controls | fe | x ~ z)` or `ivreg`; report the first
  stage, the effective F, the reduced form, and Anderson–Rubin confidence
  sets when the F is modest (`ivmodel`).
- Interpret as a LATE for compliers; characterize the compliers if possible.

## Shift-share

- The instrument built explicitly in code with the shares and shifts
  visible; Rotemberg weights (`bartik.weight`) reported; AKM standard errors
  (`ShiftShareSE`) alongside conventional clustering.

## Panel and TSCS

- `fixest::feols(y ~ x | unit + year, cluster = ~unit)` as the workhorse;
  state which fixed effects and why.
- Report the share of units with within-variation in treatment and the
  within-unit SD of treatment.
- Lag structure from theory; if a lagged DV is included with unit effects,
  say why the Nickell bias is tolerable (long T) or use an estimator that
  addresses it.
- Driscoll–Kraay or spatial HAC when cross-sectional dependence is plausible
  (`fixest::vcov_DK`, `conleyreg`).

## Dyadic

- PPML for flows with zeros (`fixest::fepois`), exporter-year, importer-year,
  and pair fixed effects for gravity; dyadic-cluster-robust standard errors
  (`dyadRobust`); cubic time polynomials for binary event outcomes.

## Selection on observables

- Preprocess with matching or entropy balancing when treated and control
  differ a lot (`MatchIt`, `WeightIt`, `ebal`), report balance (`cobalt`
  love plot), then the outcome model on the matched or weighted sample.
- `sensemakr` robustness values reported next to the headline.

## Tables (`code/04-tables.R`)

- `modelsummary::modelsummary()` with `output = "latex"` to
  `output/tables/*.tex`; `coef_map` for readable labels; `gof_map` limited
  to N, (within) R², and the fixed-effect indicators; `add_rows` for the
  clustering level and the estimator when they vary across columns.
- Column titles are outcomes or samples, not model numbers alone.
- Table notes: SE type and cluster level; sample; what the coefficient is
  (effect of a 1-SD change, marginal effect at the mean).
- One table per claim; robustness columns go to the appendix table produced
  by `/mstack:robustness`.
