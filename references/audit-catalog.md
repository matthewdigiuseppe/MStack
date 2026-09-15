# Analysis bug catalog

Read by `/mstack:results-audit`. Each entry: the bug, what it does to the
estimate, and how to detect it in code rather than by reading prose. The
audit is not done until each applicable entry has been checked against
`code/01-clean.R`, `code/02-analyze.R`, and the tables.

## Data assembly

| Bug | Effect | Detect |
|---|---|---|
| Duplicate unit-years created by a join | Inflates N; weights duplicated units; SEs too small | `anyDuplicated(df[, key_cols])` after every join; compare N to the codebook |
| Many-to-many join that was meant to be one-to-many | Rows multiplied silently | Row count before and after each join; `relationship = "one-to-one"` / `"many-to-one"` in `dplyr::left_join()` |
| Sentinel codes used as numbers (Polity −66/−77/−88, −9, 999) | Wild outliers; sign flips | `min`, `max`, value counts on integer-coded variables; histograms |
| Zero vs. missing confused (trade, aid, deaths) | Attenuates or fabricates variation | Share of exact zeros by source and year against the codebook's definition |
| Merge on country names | Silent non-matches (Côte d'Ivoire, Korea, Congo, Myanmar) | List unmatched keys from an anti-join; never accept a merge without it |
| Lag across gaps or across units | Treatment from the wrong unit or a distant year | Assert `lag(year) == year - 1` where lags are used; check `group_by()` and `arrange()` precede `lag()` |
| Lead used where a lag was intended | Reverse-timed treatment | Print the first rows of one unit with the original and shifted variable |
| Year misalignment (election year vs. survey year; fiscal year) | Treatment measured after the outcome | Cross-tab of source years in the merged frame |
| Unit boundary changes mid-panel (NUTS revisions, FIPS changes) | Fake level shifts at the revision year | Time series by unit; look for breaks at known revision years |
| Sample restriction applied to models but not descriptives, or the reverse | Table 1 N ≠ Table 2 N | Compare N across every table; every difference has a written reason |
| Standardization on the full sample, then a subsample analysis | Coefficients in the wrong units | Grep for `scale(` and check where it sits relative to filters |
| Winsorizing or trimming chosen after seeing results | Forking path | The cut is in the prereg or the plan written before estimation |
| Imputation that leaks the outcome | Overfit; understated uncertainty | Imputation model specification reviewed; outcome excluded from imputing treatment where required |

## Specification

| Bug | Effect | Detect |
|---|---|---|
| Post-treatment control (a mediator or a consequence of treatment) | Bias of unknown sign (Montgomery, Nyhan & Torres 2018) | Every control's timing relative to treatment checked against the DAG in `.mstack/theory.md` |
| Interaction without constituent terms, or reported by its coefficient alone | Uninterpretable | Constituent terms present; marginal effects at moderator values computed |
| Moderator without common support at the values reported | Extrapolation | Histogram of the moderator by treatment; binning estimator |
| Fixed effects that absorb the treatment | Effect identified from a handful of switchers | Share of units with within-variation in treatment printed |
| Clustering below the level of assignment; too few clusters with asymptotic SEs | SEs too small | Cluster variable equals the assignment level; cluster count printed; wild bootstrap below ~40 |
| Two-way fixed effects under staggered adoption | Biased weighted average | Timing variation in treatment adoption checked; heterogeneity-robust estimator used |
| Logit or probit coefficients compared across models or samples | Scale confounded with unobserved heterogeneity | AMEs reported instead |
| `log(1 + y)` on an outcome with many zeros | Unit-dependent, arbitrary | Share of zeros; PPML or a stated alternative |
| Weighted and unweighted results mixed across tables | Different estimands side by side | Weights argument checked in every model call |
| Different samples across columns without a note | Coefficients not comparable | N per column; a note stating the restriction |
| Instrument entering the second stage, or a bad control in the first stage | Invalid IV | Formula inspection of both stages |
| Multiple hypotheses with no correction; "marginally significant" | Inflated false positives | Count of tests per family; correction applied or waived in writing |
| SEs from a different model object than the coefficients | Mismatched inference | `modelsummary` built from the saved model objects, not from hand-copied numbers |
| Seeds missing for bootstrap, randomization inference, simulation, imputation | Unreproducible numbers | Grep for `set.seed(` in every stochastic script |

## Reporting

| Bug | Detect |
|---|---|
| Numbers in prose differ from the tables | Grep each coefficient and N quoted in `paper/sections/results.tex` against `output/tables/*.tex` |
| Percent vs. percentage points | Read every "percent" sentence with the outcome's scale in mind |
| SD-unit and raw-unit interpretations mixed | Check the scaling of each variable named in the text |
| CI inconsistent with SE (should be roughly ±1.96 SE, or the t critical value with few clusters) | Recompute one interval per table |
| Sign or magnitude changed between drafts without comment | Compare against `output/analyze-log.md` from the prior run |
| Figures built from a different model run than the tables | Timestamps of `output/models/*.rds`, `output/tables/*`, `output/figures/*` in order; rerun if not |
| Effect described causally under a design that does not license it | Verbs in the results section against the design type in config |

## Reproducibility

- Hard-coded paths or `setwd()`; scripts that depend on objects left in an
  interactive session; results that change with run order; output files
  overwritten by a later script; packages unpinned (`renv.lock` absent);
  `sessionInfo()` not saved.
- The end-to-end test: a fresh R session sourcing every numbered script in
  order, then a checksum comparison of `output/` against the committed
  outputs.

## Detection snippets

```r
# duplicates and row counts
stopifnot(!anyDuplicated(df[, c("country_id", "year")]))
# sentinel scan on integer-coded columns
sapply(df[sapply(df, is.numeric)], function(x) sort(unique(x[x < -1 | x %in% c(66, 77, 88, 99, 999, 9999)])))
# lag integrity within unit
df |> dplyr::group_by(country_id) |> dplyr::arrange(year, .by_group = TRUE) |>
  dplyr::mutate(gap = year - dplyr::lag(year)) |> dplyr::filter(gap != 1)
# within-unit treatment variation (share of units that ever switch)
df |> dplyr::group_by(country_id) |> dplyr::summarise(v = dplyr::n_distinct(treat) > 1) |> dplyr::summarise(mean(v))
```

```bash
# numbers quoted in prose vs. tables (crude but catches copy errors)
grep -oE '[-]?[0-9]+\.[0-9]{2,3}' paper/sections/results.tex | sort -u > /tmp/prose.txt
grep -ohE '[-]?[0-9]+\.[0-9]{2,3}' output/tables/*.tex | sort -u > /tmp/tables.txt
comm -23 /tmp/prose.txt /tmp/tables.txt   # numbers in prose that appear in no table
```
