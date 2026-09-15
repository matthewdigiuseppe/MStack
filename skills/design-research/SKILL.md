---
name: design-research
description: Chooses the research design (survey or field experiment, DiD, RD, IV, shift-share, observational panel, cross-section, qualitative) by scoring each candidate on identification of the stated estimand, external and construct validity, power, ethics, and cost, in the declare–diagnose framework, with an explicit plan B. Use after identification review, or when the user asks which design or method fits their question.
allowed-tools:
  - Read
  - Write
---

# /mstack:design-research

**Stage:** design · **Voice:** design-critic

After `/mstack:identification-review` returns at least a conditional pass. The question is no longer "can this be identified?" but "which design identifies the estimand best under the constraints?" Frame every candidate in the four parts of a design (Blair, Coppock & Humphreys 2023): the **model** of the world the theory implies, the **inquiry** (the estimand in `hypotheses.md`), the **data strategy** (sampling, assignment, measurement), and the **answer strategy** (the estimator). A design is a data strategy paired with an answer strategy; changing one without the other is where most designs go wrong.

## Procedure

1. **Load** `.mstack/hypotheses.md` (estimand, SESOI), `.mstack/identification-review-*.md` (threats to beat), `.mstack/theory.md` (rivals, scope conditions), and the design sections of `${CLAUDE_PLUGIN_ROOT}/references/identification-threats.md` for each candidate.
2. **Enumerate 2–4 designs** that could in principle answer the inquiry: survey experiment (vignette, conjoint, list); field experiment; natural or quasi-experiment (DiD / event study, RD, IV, shift-share); observational panel with fixed effects; cross-section with selection on observables; comparative case / process tracing. For each, its data strategy and answer strategy in two lines.
3. **Score each, one line per dimension:**
   - **Identification of the estimand** — the assumption the design needs, how plausible it is here, and whether the quantity it identifies (ATE, ATT, LATE at a cutoff, complier LATE) is the one the theory speaks to.
   - **External validity** — the population and setting it generalizes to, against the scope conditions in `theory.md`.
   - **Construct validity** — does the operationalization measure what theory predicts; for experiments, is the manipulation the concept or a proxy for it?
   - **Power** — is the achievable N enough for the SESOI given clustering and attrition? Numbers come from `/mstack:power-analysis`; interactions and conjoints need far more than main effects.
   - **Ethics and feasibility** — IRB, consent, deception, risk to subjects, data access, timeline.
   - **Cost** — money, fieldwork, coding labor.
4. **Recommend one.** Say why it dominates on the dimensions that matter most for this inquiry and what it gives up; no design is a free win. Say which rival mechanisms in `theory.md` it can and cannot rule out.
5. **Plan B.** If the choice fails (no IRB, no funding, scooped, a weak instrument), the closest substitute and what the headline would become. Save it so the project does not restart from zero.
6. **Save** to `.mstack/design-research.md`. In `.mstack/config.yaml` set `design.type` (`survey-experiment`, `field-experiment`, `did`, `rd`, `iv`, `shift-share`, `panel-fe`, `cross-section`, or `qualitative`) and `paper.status: "designing"`.

## Outputs

- `.mstack/design-research.md` — candidates with their data and answer strategies, scores, choice, plan B.
- `.mstack/config.yaml` — `design.type` set.
- Summary block: chosen design, the estimand it identifies, the one dimension it underperforms on.

## Anti-patterns

- **Lab or survey because it is easy.** If observational with a credible IV or RD dominates on identification and external validity, prefer it.
- **Estimator before estimand.** "We'll run a DiD" is an answer strategy looking for a question.
- **No plan B.** Designs fail.

## Next

`/mstack:power-analysis`, `/mstack:preregister`; `/mstack:survey-build` if survey-based.
