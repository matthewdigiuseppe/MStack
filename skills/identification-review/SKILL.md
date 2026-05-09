---
name: identification-review
description: Methodologist voice prosecuting the identification strategy. Names threats to inference, alternative explanations, and what would change your mind. Front-runs the R1 reviewer who would tank the paper on identification grounds. Analog to gstack's /plan-eng-review.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash(date *)
---

# /mstack:identification-review

**Stage:** map (before design lock-in) — re-run before submission
**Voice:** methodologist

## When to invoke

- After `/theory-build` and before `/design-research`: lock down identification before committing to a design.
- Before submission: re-run on the actual specification to catch what you missed.

## Procedure

1. **Load context.**
   - `.mstack/research-question.md` for the claim.
   - `.mstack/lit-map.md` for what the literature already disputes.
   - `paper/sections/methods.tex` (if it exists) for the current spec.
   - `code/02-analyze.R` (if it exists) for what is actually run.

2. **State the identifying assumption in one sentence.** If the user can't, the review fails before it starts; surface that as the top finding.

3. **Run the prosecution checklist.** For each item, name a concrete violation a reviewer could plausibly raise:

   - **Selection.** Who is in the sample? Who isn't? Is selection on the dependent variable?
   - **Confounding.** What is the most plausible omitted variable? Why does the design rule it out?
   - **Reverse causality.** Could Y cause X? What evidence rules it out?
   - **Measurement.** Is X measured pre-treatment? Is Y measured cleanly? What is the reliability?
   - **SUTVA / spillovers.** Are units independent? If not, what is the dependence structure?
   - **Effective sample.** What units actually contribute to identification (e.g., within-variation under FE)? Are they representative?
   - **Standard errors.** What is the level of clustering? What is the dependence structure that justifies it?
   - **Multiple comparisons.** How many tests? What is the family-wise error rate?
   - **Specification curve.** How many reasonable specifications exist? Have they been run? Where does the headline sit?
   - **External validity.** What is the population of generalization? Is the headline phrased to match?

4. **Falsification tests.** Name at least two:
   - **Placebo.** A sample / time / outcome where the effect should be zero. Is it?
   - **Pre-trend / pre-treatment outcome.** Does the relationship exist before treatment?
   - **Negative control.** A predictor that should not predict the outcome — does it?

5. **What would change your mind?** State, in one paragraph, what the author would have to show — additional analysis, alternative data — to rule out the most plausible threat.

6. **Verdict.**
   - **Pass** — identification is defensible against the listed threats. Document the assumption in the paper.
   - **Conditional pass** — one or two threats need additional analysis. Specify which.
   - **Fail** — the design cannot identify the claim. Recommend either redesigning or weakening the headline.

7. **Save** to `.mstack/identification-review-<YYYY-MM-DD>.md`.

## Outputs

- `.mstack/identification-review-<date>.md` — full review with assumption, threats, falsification tests, verdict.
- Summary block: assumption sentence, top 3 threats, verdict, suggested next steps.

## Anti-patterns to refuse

- **Vague threats.** "Endogeneity" is not a threat; "pre-treatment income predicts treatment assignment, which biases the coefficient downward" is.
- **Defending instead of prosecuting.** This skill is the prosecution. The user is the defense.
- **Skipping falsification tests.** If there is no test that could fail, the design isn't testing anything.

## When to call other skills

- Pre-fail: redesign with `/design-research` before any data work.
- Post-pass: proceed to `/design-research` (if pre-data) or `/preregister` (if data is about to be collected).
- Before submission: re-run; the post-fact spec often differs from the pre-fact plan.
