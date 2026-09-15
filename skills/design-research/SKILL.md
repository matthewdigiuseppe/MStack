---
name: design-research
description: Chooses the research design (survey or field experiment, RDD/IV/DiD, observational, qualitative) by scoring identification, validity, power, and cost, with an explicit plan B. Use after identification review, or when the user asks which design or method fits their question.
allowed-tools:
  - Read
  - Write
---

# /mstack:design-research

**Stage:** design · **Voice:** design-critic

After `/mstack:identification-review` returns at least a conditional pass. The question is no longer "can this be identified?" but "which design identifies it best under the constraints?"

## Procedure

1. **Load** `.mstack/hypotheses.md`, `.mstack/identification-review-*.md`, `.mstack/theory.md`.
2. **Enumerate 2–4 designs** that could in principle answer the question: survey experiment / vignette / conjoint; field experiment; lab-in-the-field; RDD / IV / DiD on observational panel data; cross-sectional observational; comparative case / process tracing.
3. **Score each, one line per dimension:**
   - **Identification** — how cleanly it separates the effect from confounds.
   - **External validity** — how representative the population it generalizes to.
   - **Construct validity** — does the operationalization measure what theory predicts?
   - **Power** — is the achievable N enough for the expected effect? (Numbers come from `/mstack:power-analysis`.)
   - **Cost** — time, money, IRB, fieldwork.
4. **Recommend one.** Say why it dominates on the dimensions that matter most for this question, and what it gives up; no design is a free win.
5. **Plan B.** If the choice fails (no IRB, no funding, scooped), what is the closest substitute? Save it so the project does not restart from zero.
6. **Save** to `.mstack/design-research.md`. In `.mstack/config.yaml` set `design.type` and `paper.status: "designing"`.

## Outputs

- `.mstack/design-research.md` — options, scores, choice, plan B.
- `.mstack/config.yaml` — `design.type` set.
- Summary block: chosen design + the one dimension it underperforms on.

## Anti-patterns

- **Lab or survey because it is easy.** If observational with a credible IV or RDD dominates on identification and external validity, prefer it.
- **No plan B.** Designs fail.

## Next

`/mstack:power-analysis`, `/mstack:preregister`; `/mstack:survey-build` if survey-based.
