---
name: identification-review
description: Methodologist prosecution of the identification strategy — the estimand, the identifying assumption in one sentence, the design-specific threats (parallel trends, manipulation at the cutoff, exclusion restrictions, shift-share exposure, post-treatment conditioning, clustering), the falsification tests and sensitivity analyses that would answer them, and a pass/fail verdict. Use before locking a design, before submission, or whenever the user asks whether the effect is identified or worries about endogeneity.
allowed-tools:
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - Bash(date *)
---

# /mstack:identification-review

**Stage:** map (re-run before submission) · **Voice:** methodologist

Run after `/mstack:theory-build` to lock identification before committing to a design, and again before submission on the actual specification, which usually differs from the plan. This skill is the prosecution; the user is the defense. The review is graded on whether a hostile methodologist reviewer could add a threat you missed.

## Procedure

1. **Load** `.mstack/research-question.md` (the claim), `.mstack/theory.md` (the DAG and the rival-mechanisms table), `.mstack/hypotheses.md` (the estimand), `.mstack/lit-map.md` (what is already disputed), `.mstack/config.yaml` (`design.type`), and, if they exist, `paper/sections/methods.tex` and `code/02-analyze.R`: the code is the truth, the prose is the claim.
2. **Read the threats reference**, `${CLAUDE_PLUGIN_ROOT}/references/identification-threats.md`: the General section and the section for this design (experiment, DiD / event study, RD, IV, shift-share, selection on observables, panel FE, cross-section, dyadic, text-as-data). If the design is unclear from the memos, infer it from the specification and say so.
3. **State the estimand and the identifying assumption**, each in one sentence a reviewer could dispute in kind ("conditional on region and year effects, the timing of exposure is unrelated to unobserved determinants of the vote"). If the user cannot supply them, that is the top finding and the review fails before it starts.
4. **Prosecution table.** For every item in the General section and in the design section, one row: threat · the concrete violation a reviewer could plausibly raise for this paper, not the generic label · what the current design does about it · the test or sensitivity analysis that would answer it · status (addressed / addressable / unaddressable). Then a row per rival mechanism from `theory.md`, with the observable implication that separates it.
   The general rows every review carries: selection into the sample; the most plausible omitted variable and why the design rules it out; reverse causality; measurement timing and validity of X and Y; SUTVA and spillovers; the effective sample that identifies the effect (which units vary, how many switch); the level of clustering and the dependence structure that justifies it; multiple comparisons; external validity and whether the headline is phrased to match the estimand.
5. **Falsification tests**, at least two, each named with what it would show and what result would be fatal:
   - **Placebo** — a sample, period, or outcome where the effect should be zero. Is it?
   - **Pre-trend / pre-treatment outcome** — does the relationship exist before treatment?
   - **Negative control** — a predictor or exposure that should not predict the outcome. Does it?
   plus the design-specific tests from the reference (density test at the cutoff, event-study pre-period, first-stage strength, Rotemberg weights and share balance, covariate balance).
6. **Sensitivity.** Name the sensitivity analysis the paper must report for this design (`sensemakr` robustness value, `HonestDiD` breakdown, plausibly-exogenous interval, bandwidth and donut sensitivity) and the sentence it should produce in the paper.
7. **What would change your mind:** one paragraph on what the author must show (an additional analysis, alternative data, a different comparison) to rule out the single most plausible threat.
8. **Verdict:** **Pass** (defensible against every listed threat; document the assumption and the tests in the paper), **Conditional pass** (one or two threats need a named analysis; list them with their tests), **Fail** (the design cannot identify the estimand; redesign, or weaken the headline to what is identified, such as a descriptive association or a LATE for a named subpopulation).
9. **Save** to `.mstack/identification-review-<YYYY-MM-DD>.md`.

## Outputs

- `.mstack/identification-review-<date>.md` — estimand, assumption, prosecution table, falsification tests, sensitivity plan, verdict.
- Summary block: assumption, top 3 threats with their tests, verdict, next step.

## Anti-patterns

- **Vague threats.** "Endogeneity" is not a threat; "pre-treatment income predicts assignment and biases β downward" is.
- **Generic threats.** A row that could be pasted into any paper has not engaged this one.
- **Defending instead of prosecuting.**
- **No falsification test.** A design nothing could fail is not testing anything.
- **Reviewing the prose, not the code.** When `02-analyze.R` exists, the specification it runs is the one under review.

## Next

Fail → `/mstack:design-research` before any data work. Pass → `/mstack:design-research` (pre-data) or `/mstack:preregister` (data about to be collected). Before submission: re-run on the final specification; `/mstack:robustness` implements the tests listed here.
