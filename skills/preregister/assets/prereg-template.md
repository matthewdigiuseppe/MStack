# Preregistration — <paper title>

Registry: <OSF | AsPredicted | EGAP | AEA> · Drafted: <YYYY-MM-DD> · Authors: <names>
Status of data access at registration: <no data collected | data exist; outcome not yet accessed | exploratory 20% split analyzed (describe)>

## 1. Hypotheses

For each hypothesis: statement, direction, estimand, SESOI, and the decision rule.

- **H1 (PRIMARY).** <Statement.> Direction: <sign>. Estimand: <ATE / ATT / LATE / CATE of what, on what, in what population and units>. SESOI: <value and units>. Decision rule: <a 95% CI excluding 0 supports H1; a CI within (−SESOI, +SESOI) is evidence against a meaningful effect; otherwise inconclusive>.
- **H2 (secondary).** <…>

## 2. Sample

- Population and sampling frame: <>
- Provider / source: <Prolific, panel name, administrative data, dataset and version>
- Target N: <n> — justification: `.mstack/power-analysis.md` (MDE at this N = <>)
- Stopping rule: <N-bound, time-bound, or both; no interim looks>
- Expected attrition and how it is handled: <report by arm; bounds if differential>

## 3. Exclusions

Every rule with its threshold, decided before data. For surveys, copy the probe manifest from `.mstack/survey-design.md`.

| Rule | Threshold | Applied to | Reported how |
|---|---|---|---|
| <e.g. attention checks> | <fails ≥ 2 of 3> | <all respondents> | <count by arm> |

## 4. Measures

- **Treatment / independent variable(s):** definition, source, scale; exact stimulus text attached as <file>; randomization scheme <complete / blocked on … / clustered by …>; assignment probability <>.
- **Outcome(s):** exact items, scoring, reverse-coding, index construction <Anderson (2008) inverse-covariance weighted / first PC / mean>, handling of missing items.
- **Covariates:** the exact list, each justified as pre-treatment; how they enter (Lin adjustment / linear controls).
- **Moderators (for H2…):** the exact list; anything not listed is exploratory.

## 5. Primary analysis

Equation: <Y_it = α + β X_it + γ' W_it + μ_i + λ_t + ε_it, variable names as in code>
- Estimator: <OLS / lm_robust / feols / Callaway–Sant'Anna / rdrobust …>, package and version <>
- Sample: <the analytic sample after exclusions>
- Standard errors: <HC2 / clustered by <unit> (K clusters) / wild cluster bootstrap>
- Test: <two-sided, α = 0.05>; the quantity tested is <β / the AME / the ATT>
- Software: R <version>; seed <>

## 6. Secondary analyses

Each with estimand and model; multiplicity policy: <Benjamini–Hochberg at q = 0.05 within this family / none, with reason>.

## 7. Robustness (pre-committed)

<From `references/robustness-protocols.md`: alternative operationalizations, samples, SE structures, estimator, sensitivity analysis to be reported (e.g. sensemakr robustness value; HonestDiD).>

## 8. Deviations policy and SOP

Any deviation from this plan is reported in the paper next to the original plan. For unanticipated problems the plan does not cover, we follow the standard operating procedures at <link / attached>, adopted <date>. Analyses not listed above are labeled exploratory.

## 9. Data and code availability

<Repository (OSF / Dataverse), timing (on acceptance), restrictions; the replication package will follow `/mstack:archive`.>
