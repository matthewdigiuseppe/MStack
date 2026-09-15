---
name: identification-review
description: Methodologist prosecution of the identification strategy — the identifying assumption, concrete threats (selection, confounding, reverse causality, SUTVA, clustering), falsification tests, pass/fail verdict. Use before locking a design, before submission, or whenever the user asks whether the effect is identified or worries about endogeneity.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash(date *)
---

# /mstack:identification-review

**Stage:** map (re-run before submission) · **Voice:** methodologist

Run after `/mstack:theory-build` to lock identification before committing to a design, and again before submission on the actual specification, which usually differs from the plan. This skill is the prosecution; the user is the defense.

## Procedure

1. **Load** `.mstack/research-question.md` (the claim), `.mstack/lit-map.md` (what is already disputed), and, if they exist, `paper/sections/methods.tex` (the current spec) and `code/02-analyze.R` (what is actually run).
2. **State the identifying assumption in one sentence.** If the user cannot, that is the top finding and the review fails before it starts.
3. **Prosecution checklist.** For each item name a concrete violation a reviewer could plausibly raise:
   - **Selection** — who is in the sample, who is not; selection on the dependent variable?
   - **Confounding** — the most plausible omitted variable; why the design rules it out.
   - **Reverse causality** — could Y cause X; what rules it out?
   - **Measurement** — X measured pre-treatment? Y measured cleanly? Reliability?
   - **SUTVA / spillovers** — are units independent; if not, what is the dependence structure?
   - **Effective sample** — which units actually identify the effect (e.g. within-variation under FE); are they representative?
   - **Standard errors** — clustering level, and the dependence structure that justifies it.
   - **Multiple comparisons** — how many tests; family-wise error rate.
   - **Specification curve** — how many reasonable specs exist, have they been run, where does the headline sit?
   - **External validity** — the population of generalization; is the headline phrased to match?
4. **Falsification tests**, at least two, each named with what it would show:
   - **Placebo** — a sample, period, or outcome where the effect should be zero. Is it?
   - **Pre-trend / pre-treatment outcome** — does the relationship exist before treatment?
   - **Negative control** — a predictor that should not predict the outcome. Does it?
5. **What would change your mind:** one paragraph on what the author must show (additional analysis, alternative data) to rule out the most plausible threat.
6. **Verdict:** **Pass** (defensible against the listed threats; document the assumption in the paper), **Conditional pass** (one or two threats need a named additional analysis), **Fail** (the design cannot identify the claim; redesign or weaken the headline).
7. **Save** to `.mstack/identification-review-<YYYY-MM-DD>.md`.

## Outputs

- `.mstack/identification-review-<date>.md` — assumption, threats, falsification tests, verdict.
- Summary block: assumption, top 3 threats, verdict, next step.

## Anti-patterns

- **Vague threats.** "Endogeneity" is not a threat; "pre-treatment income predicts assignment and biases β downward" is.
- **Defending instead of prosecuting.**
- **No falsification test.** A design nothing could fail is not testing anything.

## Next

Fail → `/mstack:design-research` before any data work. Pass → `/mstack:design-research` (pre-data) or `/mstack:preregister` (data about to be collected).
