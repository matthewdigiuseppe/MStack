---
name: preregister
description: Drafts an OSF / AsPredicted preregistration document. Writes to prereg/osf-prereg.md and updates .mstack/config.yaml. Use before any data collection or analysis on a fresh sample.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash(date *)
---

# /mstack:preregister

**Stage:** design
**Voice:** preregistration-clerk

## When to invoke

Before fielding a survey, before running a secondary-data analysis on a sample you haven't touched, or before any design where you want to credibly distinguish confirmatory from exploratory analysis.

## Procedure

1. **Load context.**
   - `.mstack/research-question.md`, `.mstack/lit-map.md`, `.mstack/identification-review-*.md`.
   - `.mstack/survey-design.md` if a survey is involved.
   - `paper/sections/theory.tex` and `methods.tex` if drafted.

2. **Pick a registry.** Default to OSF; AsPredicted if the design is small (≤ 9-section format). Note the choice in the document header.

3. **Draft `prereg/osf-prereg.md`** with these sections, all required:

   ### 1. Hypotheses
   List H1, H2, … with direction and effect size sign. State which is primary; secondaries are explicitly secondary.

   ### 2. Sample
   - Population.
   - Recruitment source (Prolific, MTurk, panel name, observational frame).
   - Target N. Justification = `/power-analysis` output.
   - Stopping rule: time-bound, N-bound, or both.

   ### 3. Exclusions
   List every exclusion rule with a threshold, decided **before** seeing data. From `survey-design.md` probe manifest if applicable.

   ### 4. Measures
   - Independent variable(s) — definition, source, scale.
   - Dependent variable(s) — definition, source, scale, scoring rule.
   - Covariates — what is controlled for, why.

   ### 5. Primary analysis
   The one specification that tests H1. State equation, sample, SE clustering, software, and the rejection rule (e.g., two-sided test at α = 0.05).

   ### 6. Secondary analyses
   Pre-specified secondaries and any planned heterogeneity / moderation tests.

   ### 7. Robustness
   List the robustness checks committed to in advance (e.g., alternative samples, alternative operationalizations, alternative SE structures).

   ### 8. Deviations policy
   Any deviation from the prereg will be reported in the paper as a deviation, with rationale. Exploratory analyses will be labeled exploratory.

   ### 9. Data and code availability
   Where data and code will be posted upon acceptance.

4. **Pre-flight check.** Refuse to mark the prereg as ready until:
   - [ ] All hypotheses have a sign.
   - [ ] Primary analysis is specific enough that two researchers would code it identically.
   - [ ] Exclusions have thresholds.
   - [ ] Power analysis exists in `.mstack/power-analysis.md`.
   - [ ] Stopping rule is concrete.

5. **Update `.mstack/config.yaml`:** set `design.prereg: true` and stub the URL field (user fills in after registry submission).

6. **Hand-off.** Print the next steps to the user: copy the rendered Markdown into OSF / AsPredicted, paste the resulting URL into `.mstack/config.yaml`, then proceed to fielding / analysis.

## Outputs

- `prereg/osf-prereg.md` — the preregistration document.
- `.mstack/config.yaml` — `design.prereg` flipped to true; URL field stubbed.
- A summary block reminding the user: register before fielding, paste the URL back into config.

## Anti-patterns to refuse

- **Vague primary analysis.** "We will run a regression" is not a specification.
- **No stopping rule.** "We'll stop when we have enough" guarantees a garden of forking paths.
- **Exclusions without thresholds.** "Exclude inattentive respondents" is not a rule; "exclude respondents who fail ≥ 2 of 3 attention checks" is.
- **Hidden moderation tests.** Heterogeneity analyses must be pre-specified or labeled exploratory in the paper.

## When to call other skills

- Before: `/identification-review`, `/power-analysis`, `/survey-build` (if survey-based).
- After: proceed to fielding / `/data-acquire`. Do not run `/analyze` until preregistered if you intend the analysis to be confirmatory.
