---
name: preregister
description: Drafts a complete OSF/AsPredicted preregistration — hypotheses, sample, thresholded exclusions, measures, exact primary specification, robustness, deviations policy — and refuses to call it ready until every field is specific. Use before fielding or touching a fresh sample, or when the user mentions preregistration, OSF, or AsPredicted.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash(date *)
---

# /mstack:preregister

**Stage:** design · **Voice:** preregistration-clerk

Before fielding a survey, before analyzing a sample you have not touched, or whenever confirmatory must be credibly separable from exploratory. Expects `/mstack:identification-review` and `/mstack:power-analysis` to have run, plus `/mstack:survey-build` if survey-based.

## Procedure

1. **Load** `.mstack/research-question.md`, `.mstack/lit-map.md`, `.mstack/hypotheses.md`, `.mstack/identification-review-*.md`; `.mstack/survey-design.md` if a survey is involved; `paper/sections/theory.tex` and `methods.tex` if drafted.
2. **Registry.** Default OSF; AsPredicted for small designs (its 9-section format). Note the choice in the header.
3. **Draft `prereg/osf-prereg.md`** from `${CLAUDE_PLUGIN_ROOT}/skills/preregister/assets/prereg-template.md`. All nine sections are required:
   1. **Hypotheses** — H1, H2, … with direction and effect-size sign; one primary, the rest explicitly secondary.
   2. **Sample** — population; recruitment source (Prolific, MTurk, panel, observational frame); target N justified by `/mstack:power-analysis`; stopping rule (time-bound, N-bound, or both).
   3. **Exclusions** — every rule with a threshold, decided before seeing data; from the survey probe manifest if applicable.
   4. **Measures** — IV(s) and DV(s) with definition, source, scale, scoring rule; covariates and why.
   5. **Primary analysis** — the one specification testing H1: equation, sample, SE clustering, software, rejection rule (e.g. two-sided test at α = 0.05).
   6. **Secondary analyses** — pre-specified secondaries and any heterogeneity / moderation tests.
   7. **Robustness** — checks committed to in advance (alternative samples, operationalizations, SE structures).
   8. **Deviations policy** — deviations reported as deviations with rationale; unlisted analyses labeled exploratory.
   9. **Data and code availability** — where they will be posted on acceptance.
4. **Pre-flight.** Refuse to mark the prereg ready until: every hypothesis has a sign; the primary analysis is specific enough that two researchers would code it identically; exclusions have thresholds; `.mstack/power-analysis.md` exists; the stopping rule is concrete.
5. **Config.** Set `design.prereg: true` in `.mstack/config.yaml` and stub `prereg_url` for the user to fill after registration.
6. **Hand-off.** Tell the user: copy the Markdown into OSF / AsPredicted, paste the resulting URL into `.mstack/config.yaml`, then field / analyze.

## Outputs

- `prereg/osf-prereg.md` — the preregistration.
- `.mstack/config.yaml` — `design.prereg: true`, URL stubbed.
- Summary block: register before fielding; paste the URL back.

## Anti-patterns

- **Vague primary analysis.** "We will run a regression" is not a specification.
- **No stopping rule.** "When we have enough" guarantees a garden of forking paths.
- **Exclusions without thresholds.** "Inattentive respondents" is not a rule; "fails ≥ 2 of 3 attention checks" is.
- **Hidden moderation tests.** Pre-specify or label exploratory.

## Next

Field / `/mstack:data-acquire`. If the analysis is meant to be confirmatory, do not run `/mstack:analyze` before registering.
