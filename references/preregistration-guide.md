# Preregistration guide

Read by `/mstack:preregister` before drafting, and by `/mstack:hypothesis-
design` and `/mstack:analyze` for the parts they feed. The bundled template
is `skills/preregister/assets/prereg-template.md`.

## The standard

A pre-analysis plan that says "we will regress Y on X with appropriate
controls" constrains nothing (Olken 2015). Ofosu & Posner's (2023) stocktaking
of political science PAPs found most leave the choices that matter open. The
test to apply to every section: could two researchers, given only this
document and the data, produce the same primary table without talking to
each other? If not, the section is not finished.

## Registries

- **OSF Registrations**: general; the "OSF Preregistration" template for
  experiments and the "Secondary Data Preregistration" template for existing
  data; supports embargoes.
- **AsPredicted**: nine short questions; fine for a simple experiment,
  cramped for a panel study.
- **EGAP** (via OSF): the field-experiment registry in political science.
- **AEA RCT Registry**: economics field experiments; some journals expect it.
- A time-stamped, immutable registration is the point; a plan in a private
  repository is a plan, not a preregistration.

## What must be specific, with vague-to-specific examples

1. **Hypotheses.** Direction, estimand, and the smallest effect size of
   substantive interest (SESOI).
   - Vague: "H1: trade exposure increases protectionist voting."
   - Specific: "H1: the effect of a one-SD increase in regional import
     exposure on the protectionist vote share (percentage points), estimated
     as the ATT in the primary specification, is positive. SESOI = 1 pp. A
     95% CI excluding 0 supports H1; a CI lying entirely within (−1, 1) is
     evidence against a substantively meaningful effect (equivalence test);
     anything else is inconclusive."
2. **Sample and stopping rule.** Frame, provider, N, dates, and the rule:
   "2,000 completes or 30 June 2026, whichever comes first; no interim
   looks."
3. **Exclusions.** Every rule with a threshold decided before data, copied
   from the probe manifest for surveys; how excluded cases are reported.
4. **Outcome construction.** Exact items, scoring, reverse-coding, the
   index method (inverse-covariance weighting per Anderson 2008, first
   principal component, or a simple mean, chosen now), and how missing items
   are handled.
5. **Treatment.** The exact stimulus text or exposure definition
   (attached), the randomization scheme (complete, blocked, clustered),
   blocking variables, and the assignment probability.
6. **Primary model.** The equation with variable names as they will appear
   in code, the covariate set named, functional form, fixed effects,
   standard-error type and clustering level, software and package with
   version, one- or two-sided test, alpha, and the estimator for the design
   (e.g. Callaway–Sant'Anna for staggered adoption).
7. **Secondary analyses and heterogeneity.** Each pre-specified with its
   own estimand; the multiplicity policy (e.g. Benjamini–Hochberg at q = 0.05
   within the family of secondaries); moderators listed exhaustively, with
   the statement that any other subgroup analysis is exploratory.
8. **Robustness pre-committed.** The list from `robustness-protocols.md`
   that applies, so that later checks are confirmatory.
9. **Deviations policy and standard operating procedures.** Deviations are
   reported in the paper with the original plan alongside; for problems the
   plan did not anticipate (attrition beyond X, a failed manipulation check,
   a data source withdrawn), adopt a written SOP in advance (Lin & Green
   2016) and link it.
10. **Data and code.** Where they will be posted; the blinding plan for
    secondary data.

## Secondary and observational data

Preregistration still buys credibility when the data already exist, if the
plan is registered before the analyst sees the treatment–outcome
relationship:

- Register before merging the outcome to the treatment, or before accessing
  the outcome at all; state exactly what has already been seen (descriptive
  tables, prior papers on the same data).
- Split the sample: an exploratory subset (say 20%) used to settle
  specifications, then a registered plan applied to the holdout (Fafchamps
  & Labonne 2017; Anderson & Magruder 2017).
- Pre-specify the estimator for the design, the comparison group, the
  window, and the treatment definition, since these are where the forking
  paths live in observational work.

## Power

Import the report from `/mstack:power-analysis`: the MDE at the planned N,
the assumptions (effect size source, ICC, attrition, clustering), and the
statement of what an inconclusive result will be interpreted as. A
preregistration without a power section invites the "underpowered null"
objection at review.

## Common failures to refuse

- Index construction left open.
- Covariates "as needed" or "standard controls".
- No multiplicity plan with more than one hypothesis.
- No stopping rule or attrition handling.
- Heterogeneity "to be explored".
- Model changes later described as "robustness".
- A prereg written after seeing the pilot's outcome data without saying so.
