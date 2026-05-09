---
name: design-research
description: Picks the design type (survey, experiment, quasi-experiment, observational) and justifies the trade-offs against alternatives. Use after /identification-review and before /preregister.
user-invocable: true
allowed-tools:
  - Read
  - Write
---

# /mstack:design-research

**Stage:** design
**Voice:** design-critic

## When to invoke

After `/identification-review` produces at least a `Conditional pass`. The question is no longer "can this be identified?" but "which design identifies it best given the constraints?"

## Procedure

1. **Load.** `.mstack/hypotheses.md`, `.mstack/identification-review-*.md`, `.mstack/theory.md`.

2. **Enumerate the design options.** For the user's question, what designs could in principle answer it? Typically 2–4 of:
   - Survey experiment / vignette / conjoint.
   - Field experiment.
   - Lab-in-the-field.
   - RDD / IV / DiD on observational panel data.
   - Pure cross-section observational.
   - Comparative case / process-tracing (qualitative).

3. **Score each design on five dimensions** (qualitatively, 1 line per dim):

   | Dim | What to ask |
   |---|---|
   | **Identification** | How cleanly does this design separate the effect from confounds? |
   | **External validity** | How representative is the population the design generalizes to? |
   | **Construct validity** | Does the operationalization measure what theory predicts? |
   | **Statistical power** | Is the achievable N at this design enough to detect the expected effect? (Defer to `/power-analysis`.) |
   | **Cost** | Time, money, IRB, fieldwork. |

4. **Recommend one.** State why this design dominates the others on the dimensions that matter most given the question. Be explicit about what the chosen design *gives up* — don't pretend it's a free win.

5. **Identify the closest substitute.** If the chosen design fails (e.g., no IRB, no funding, scoop), what's plan B? Save plan B to the file so the project doesn't restart from zero.

6. **Save** to `.mstack/design-research.md`. Update `.mstack/config.yaml`'s `design.type` field.

## Outputs

- `.mstack/design-research.md` — option set, scores, choice, plan B.
- `.mstack/config.yaml` — `design.type` set.
- Summary block: chosen design + the one dimension it underperforms on.

## Anti-patterns to refuse

- **Default to lab/survey because it's easy.** If observational with a credible IV or RDD is dominant on identification + external validity, prefer it.
- **No plan B.** Designs fail. Have a fallback.

## When to call other skills

- After: `/power-analysis`, `/preregister`. If survey-based, `/survey-build`.
