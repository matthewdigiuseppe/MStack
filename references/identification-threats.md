# Identification threats and tests, by design

Read by `/mstack:identification-review` (the prosecution), `/mstack:design-research`
(choosing between designs), `/mstack:analyze` and `/mstack:robustness` (what to
estimate and what to vary), and `/mstack:referee-mock` (what a methodologist
reviewer will ask). Read **General** and then the section matching
`design.type` in `.mstack/config.yaml`, or the design the specification
implies. Citations are pointers for the author, not decoration: cite them in
the paper where the argument leans on them.

## General (every design)

- **Estimand first.** Name the population, the unit, the treatment contrast,
  and the target quantity (ATE, ATT, LATE, CATE, a descriptive quantity)
  before any estimator (Lundberg, Johnson & Stewart 2021). A hypothesis
  without an estimand cannot be identified or falsified, and "the coefficient
  on X" is not an estimand.
- **One-sentence identifying assumption** a reviewer could dispute in kind:
  "conditional on region and year effects, timing of exposure is unrelated to
  unobserved determinants of the vote." If the sentence needs "controls" to be
  true, list the controls and say why the set is sufficient.
- **Post-treatment bias.** Never condition on a consequence of treatment
  (Montgomery, Nyhan & Torres 2018): mediators, colliders, and anything
  measured after treatment that treatment could move. Draw the DAG and read
  off the colliders (Elwert & Winship 2014).
- **Measurement.** X measured before Y and before any response to X; Y not
  mechanically related to X (shared denominators, overlapping indices);
  reliability of expert-coded indices; construct validity of the proxy.
- **SUTVA.** Interference across units (spillovers, contagion, general
  equilibrium) and multiple versions of treatment. Say what the unit's
  neighbors could do to it.
- **Positivity / common support.** Overlap of treated and control on the
  conditioning set; interactions need support at both moderator levels and
  the effect must be linear in the moderator or estimated flexibly
  (Hainmueller, Mummolo & Xu 2019).
- **Inference.** Cluster where treatment is assigned, not where the outcome
  is measured (Abadie, Athey, Imbens & Wooldridge 2023). Few clusters (fewer
  than ~40) call for the wild cluster bootstrap (Cameron, Gelbach & Miller
  2008). Serial correlation in panels inflates precision (Bertrand, Duflo &
  Mullainathan 2004). Spatial or dyadic dependence needs its own correction
  (Conley 1999; Aronow, Samii & Assenova 2015).
- **Multiple comparisons.** One pre-specified primary; secondaries corrected
  (Benjamini–Hochberg for FDR; Romano–Wolf for family-wise) or explicitly
  labeled exploratory.
- **External validity.** The population of generalization, stated; the
  headline phrased to match (a survey experiment on a panel does not license
  "voters").
- **Broadly applicable falsification tests:** placebo outcomes the treatment
  should not move; placebo treatments or timings; negative-control exposures;
  balance on pre-treatment covariates; effects that should be absent where
  the mechanism cannot operate.

## Randomized experiments (lab, survey, field)

**Threats.** Randomization failure (a balance table is a diagnostic, not a
proof; large imbalances on prognostic covariates matter, p-values on
balance do not). Noncompliance: report ITT, and CACE/LATE only with a
defensible exclusion restriction. Attrition: differential attrition breaks
randomization; report attrition by arm, test for differential attrition, and
bound (Lee 2009 trimming bounds; Manski bounds). Interference: units talk,
share, or compete; randomize at the level where spillovers are contained or
use two-stage designs. Demand and Hawthorne effects. Pretreatment: subjects
already exposed to the treatment in the world dilute or contaminate the
manipulation (Druckman & Leeper 2012). Manipulation checks measure whether
the treatment was received; attention checks measure whether the respondent
was reading; they are not interchangeable and post-treatment attention
checks used as exclusions can bias estimates (Kane & Barabas 2019). Fishing
in heterogeneous effects. Covariate adjustment should be pre-specified and
done with treatment-by-covariate interactions or Lin (2013) adjustment.

**Survey experiments specifically.** External validity of the sample and the
stimulus (Barabas & Jerit 2010; Coppock 2019 on generalizing from
convenience samples). Vignette realism and information equivalence across
arms (Dafoe, Zhang & Caughey 2018). Conjoints: the AMCE is a causal average
over the profile distribution (Hainmueller, Hopkins & Yamamoto 2014); use
marginal means, not AMCEs, to compare subgroups (Leeper, Hobolt & Tilley
2020); restrict implausible profiles carefully and report the restriction;
satisficing rises with tasks, so justify the number of tasks; randomize
attribute order; power for conjoints is about the number of profiles times
attribute levels, not respondents alone (Schuessler & Freitag 2020).

**Tests.** Balance table on pre-treatment covariates; pre-registered primary
outcome; manipulation check by arm; placebo outcomes; randomization
inference for the sharp null (`ri2`).

## Difference-in-differences and event studies

**Threats.** Parallel trends is untestable; pre-trends are evidence, not
proof, and pre-testing distorts inference (Roth 2022). Anticipation.
Staggered adoption with heterogeneous effects makes two-way fixed effects a
weighted average with possibly negative weights (Goodman-Bacon 2021; de
Chaisemartin & D'Haultfœuille 2020); use an estimator built for it: Callaway
& Sant'Anna (2021), Sun & Abraham (2021), Borusyak, Jaravel & Spiess (2024),
Gardner (2022); the survey is Roth, Sant'Anna, Bilinski & Poe (2023).
Treatment reversals. Compositional change in the panel. Time-varying
confounders that also move at treatment. Parallel trends is functional-form
specific (levels vs. logs). Few treated clusters break standard inference
(Conley & Taber 2011; Ferman & Pinto 2019).

**Tests.** Event-study plot with the pre-period coefficients and their
joint test; sensitivity to violations of parallel trends (Rambachan & Roth
2023, `HonestDiD`); placebo timing; alternative comparison groups; synthetic
control when there are few treated units (Abadie 2021).

## Regression discontinuity

**Threats.** Manipulation of the running variable (McCrary 2008; Cattaneo,
Jansson & Ma 2020 density test). Bandwidth: MSE-optimal with robust
bias-corrected confidence intervals (Calonico, Cattaneo & Titiunik 2014),
local linear rather than global polynomials (Gelman & Imbens 2019).
Covariates jumping at the cutoff. Compound treatments: other things change
at the same threshold. Fuzzy RD identifies a LATE for compliers at the
cutoff. Heaping and discrete running variables (Kolesár & Rothe 2018).
The estimand is local to the cutoff; say so in the headline.

**Tests.** Density test; covariate continuity at the cutoff; placebo cutoffs;
bandwidth sensitivity plot; donut RD; binned-mean plot with the fit. The
practical guide is Cattaneo, Idrobo & Titiunik (2020); tools `rdrobust`,
`rddensity`, `rdlocrand`.

## Instrumental variables

**Threats.** The exclusion restriction is untestable and must be argued
substantively: every channel from instrument to outcome other than
treatment, ruled out one by one. Weak instruments: report the effective
first-stage F and use weak-instrument-robust inference (Anderson–Rubin
confidence sets; Lee, McCrary, Moreira & Porter 2022 on the tF procedure).
Monotonicity (no defiers) for a LATE interpretation, and the LATE is for
compliers, who may be nobody the theory cares about. Instruments that proxy
another treatment. Overidentification tests are weak evidence for
exclusion.

**Tests.** First stage and reduced form reported in full; zero-first-stage
subsamples where the reduced form should vanish; placebo outcomes;
"plausibly exogenous" sensitivity to small violations (Conley, Hansen & Rossi
2012).

## Shift-share (Bartik) instruments

**Threats.** Identification rests on either exogenous shares (Goldsmith-
Pinkham, Sorkin & Swift 2020: the Rotemberg weights say which shares carry
the estimate, so those shares must be uncorrelated with other determinants
of the outcome) or exogenous shifts with many independent industries
(Borusyak, Hull & Jaravel 2022). Standard errors must account for the shared
industry-level shocks (Adão, Kolesár & Morales 2019). Pre-trends correlated
with the shares. Concurrent shocks (automation, other trading partners) in
the China-shock design of Autor, Dorn & Hanson (2013), where the shift is
imports into comparable high-income countries.

**Tests.** Rotemberg weights and the balance of the high-weight shares on
pre-period outcomes and trends; pre-trend on the instrument; AKM standard
errors; placebo shifts from unrelated industries.

## Selection on observables (regression, matching, weighting)

**Threats.** Omitted variables: argue from the DAG why the conditioning set
closes every back door. Overcontrol on post-treatment variables. Functional
form and extrapolation off common support (King & Zeng 2006). Model
dependence, reducible by matching or weighting as preprocessing (Ho, Imai,
King & Stuart 2007; Hainmueller 2012 on entropy balancing).

**Sensitivity.** How strong an unobserved confounder would have to be:
robustness values and contour plots (Cinelli & Hazlett 2020, `sensemakr`);
coefficient movement relative to R² movement (Oster 2019, with its
assumptions stated); Rosenbaum bounds after matching. Balance diagnostics
after matching or weighting (`cobalt`). A specification curve over the
defensible conditioning sets.

## Panel and TSCS data with fixed effects

**Threats.** Unit fixed effects remove time-invariant confounders only;
time-varying confounders remain. A lagged dependent variable with unit
effects is biased in short panels (Nickell 1981). Reverse causality and
feedback within units. Unit roots and spurious regression in long panels.
Serial correlation, so cluster by unit (Bertrand, Duflo & Mullainathan
2004); cross-sectional dependence (Driscoll–Kraay). Few units. Fixed effects
identify from within-unit variation: report which units have any and how
much, because the effective sample is often a handful of movers (Mummolo &
Peterson 2018). Lag choice must come from theory, not from the lag that
works (Keele & Kelly 2006).

**Tests.** Within-unit variation summary; alternative fixed-effect
structures; leads of treatment as a placebo; dynamic specifications;
leave-one-unit-out and leave-one-period-out.

## Cross-sectional observational data

Everything above without the help of within-unit variation. Add: ecological
inference when aggregate data stand in for individual behavior; survey
design and weights; the measurement model behind institutional indices
(V-Dem's Bayesian IRT scores carry uncertainty; Polity and Freedom House
have known construct-validity critiques); the endogeneity of institutions
to the outcomes they are said to cause.

**Tests.** Alternative measures of the same construct; sensitivity to
unobservables; placebo outcomes; results by data source.

## Dyadic and network data (trade, conflict, alliances, migration)

**Threats.** Dyadic dependence: each state appears in many dyads, so
observations are not independent; use dyadic-cluster-robust standard errors
(Aronow, Samii & Assenova 2015; Carlson, Incerti & Aronow 2024). Directed vs.
undirected dyads. Zeros in trade or flows: PPML rather than log-linear OLS
(Santos Silva & Tenreyro 2006); multilateral resistance via exporter-year,
importer-year, and pair fixed effects (Yotov, Piermartini, Monteiro & Larch
2016). Selection into "politically relevant" dyads. Temporal dependence in
binary outcomes: cubic polynomials in time since the last event (Carter &
Signorino 2010; Beck, Katz & Tucker 1998).

## Text-as-data and LLM-coded measures

**Threats.** The classifier is a measurement instrument with error;
classification error correlated with treatment or with the outcome is
differential measurement error and biases the coefficient in unknown
directions. Predicted labels used as variables need a correction that uses
the validation set (Fong & Tyler 2021; Egami, Hinck, Stewart & Wei 2023).
Model version drift for LLM coders (log every run with
`/mstack:llm-checklist`). Validation against a hand-coded gold standard is
required, not optional (Grimmer & Stewart 2013; Grimmer, Roberts & Stewart
2022).

**Tests.** Precision, recall, and inter-coder agreement on the gold set;
sensitivity to the classification threshold; results with the correction
applied.

## Case-based and qualitative designs

Process tracing evidence has types (hoop, smoking gun, straw in the wind,
doubly decisive; Van Evera 1997; Bennett & Checkel 2015). Case selection
should be stated as a strategy, not a convenience (Seawright & Gerring
2008), and selecting on the outcome without variation cannot establish an
effect. A qualitative section inside a quantitative paper should test an
observable implication of the mechanism that the regressions cannot.

## Sensitivity and estimation tools, R

| Purpose | Package |
|---|---|
| Unobserved-confounder sensitivity | `sensemakr` |
| Parallel-trends sensitivity | `HonestDiD` |
| Staggered DiD | `did`, `didimputation`, `fixest::sunab()`, `did2s` |
| Regression discontinuity | `rdrobust`, `rddensity`, `rdlocrand` |
| IV with weak-instrument-robust CIs | `ivmodel`, `fixest` (IV syntax) |
| Shift-share inference | `ShiftShareSE` (AKM), `bartik.weight` (Rotemberg weights) |
| Clustered and few-cluster inference | `sandwich::vcovCL`, `clubSandwich`, `fwildclusterboot` |
| Dyadic clustering | `dyadRobust` |
| Randomization inference | `ri2` |
| Matching and weighting diagnostics | `MatchIt`, `WeightIt`, `ebal`, `cobalt` |
| Specification curves | `specr` |
| Design diagnosis and power | `DeclareDesign` |
