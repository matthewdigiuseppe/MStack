---
name: preregister
description: Drafts a preregistration that meets the two-researchers test — hypotheses with estimand, smallest effect of interest, and decision rule; sample and stopping rule; thresholded exclusions; outcome and index construction; the exact primary model as it will appear in code; multiplicity policy; pre-committed robustness; deviations policy with standard operating procedures; blinding plan for existing data — and refuses to mark it ready until every field is specific. Use before fielding or before touching a fresh sample, or when the user mentions preregistration, a pre-analysis plan, OSF, EGAP, or AsPredicted.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash(date *)
---

# /mstack:preregister

**Stage:** design · **Voice:** preregistration-clerk

Before fielding a survey, before analyzing a sample you have not touched, or whenever confirmatory must be credibly separable from exploratory. Expects `/mstack:hypothesis-design`, `/mstack:identification-review`, and `/mstack:power-analysis` to have run, plus `/mstack:survey-build` if survey-based. The bar throughout: could two researchers, given only this document and the data, produce the same primary table without talking?

## Procedure

1. **Load** `.mstack/hypotheses.md` (estimands, SESOIs, decision rules), `.mstack/identification-review-*.md` (the tests to pre-commit), `.mstack/theory.md` (rivals), `.mstack/power-analysis.md`, `.mstack/research-question.md`, `.mstack/lit-map.md`; `.mstack/survey-design.md` if a survey is involved; `paper/sections/theory.tex` and `methods.tex` if drafted.
2. **Read** `${CLAUDE_PLUGIN_ROOT}/references/preregistration-guide.md` for the specificity standard and the vague-to-specific examples, and `${CLAUDE_PLUGIN_ROOT}/references/robustness-protocols.md` for what to pre-commit.
3. **Registry and data status.** OSF by default (the Secondary Data template when the data already exist); AsPredicted for a simple experiment; EGAP for a field experiment in political science; the AEA registry if an economics audience expects it. Record in the header what has already been seen of the data (nothing; descriptives only; an exploratory split), because a plan that hides prior looks is worse than none.
4. **Draft `prereg/osf-prereg.md`** from `${CLAUDE_PLUGIN_ROOT}/skills/preregister/assets/prereg-template.md`. All nine sections are required:
   1. **Hypotheses** — each with direction, estimand, SESOI, and the decision rule (support / evidence against a meaningful effect via the equivalence region / inconclusive); one primary, the rest explicitly secondary; the rival-discriminating hypotheses from `hypotheses.md` included.
   2. **Sample** — population, frame, provider or dataset with version, target N justified by `/mstack:power-analysis`, stopping rule with no interim looks, expected attrition and its handling.
   3. **Exclusions** — every rule with a threshold decided before data; from the probe manifest if survey-based; how excluded cases are reported.
   4. **Measures** — exact items and stimulus text attached; scoring, reverse-coding, index construction fixed now; the covariate list with each justified as pre-treatment; the exhaustive moderator list.
   5. **Primary analysis** — the equation with variable names as they will appear in code, the estimator for the design (a heterogeneity-robust DiD estimator under staggered adoption, `rdrobust` for RD, and so on), sample, standard-error type and cluster level, test and alpha, software with versions.
   6. **Secondary analyses** — each with its estimand; the multiplicity policy for the family.
   7. **Robustness** — the checks committed to in advance, including the sensitivity analysis named in the identification review.
   8. **Deviations policy and SOP** — deviations reported alongside the original plan; standard operating procedures for unanticipated problems adopted and linked (Lin & Green 2016).
   9. **Data and code availability** — repository, timing, restrictions, and the blinding plan for secondary data (register before the outcome is merged to the treatment; or an exploratory split with the holdout untouched).
5. **Pre-flight.** Refuse to mark the plan ready until: every hypothesis has direction, estimand, SESOI, and decision rule; the primary model could be coded from the text alone; index construction and the covariate list are fixed; every exclusion has a threshold; the stopping rule is concrete; more than one hypothesis comes with a multiplicity policy; the power section is imported with its assumptions; for existing data, the data-access statement and the blinding plan are honest.
6. **Config.** Set `design.prereg: true` in `.mstack/config.yaml` and stub `prereg_url` for the user to fill after registration.
7. **Hand-off.** Tell the user: copy the Markdown into the registry, paste the resulting URL into `.mstack/config.yaml`, then field or analyze; keep the registered text in `prereg/` unchanged and put later edits in a dated addendum.

## Outputs

- `prereg/osf-prereg.md` — the preregistration.
- `.mstack/config.yaml` — `design.prereg: true`, URL stubbed.
- Summary block: registry, data-access status, the items still failing pre-flight if any; register before fielding, paste the URL back.

## Anti-patterns

- **Vague primary analysis.** "We will run a regression" is not a specification; neither is "appropriate controls".
- **No stopping rule.** "When we have enough" guarantees a garden of forking paths.
- **Exclusions without thresholds.** "Inattentive respondents" is not a rule; "fails ≥ 2 of 3 attention checks" is.
- **Open index construction.** The outcome must be computable from the plan.
- **Hidden moderation tests.** Pre-specify or label exploratory.
- **A plan written after peeking**, without saying so.

## Next

Field / `/mstack:data-acquire`. If the analysis is meant to be confirmatory, do not run `/mstack:analyze` before registering.
