---
name: research-question
description: Interrogates a paper idea with six forcing questions — contribution, audience, identification, falsifiability, feasibility, scoop risk — and issues a green/yellow/red verdict. Use when the user pitches a new paper, asks whether a project is worth pursuing, or wants a research question pressure-tested before committing.
allowed-tools:
  - Read
  - Write
  - Bash(date *)
---

# /mstack:research-question

**Stage:** ideate · **Voice:** advisor

An interrogation, not a brainstorm: these are the questions that, asked at month six, become reasons to abandon a project. Do not encourage before the answers are in.

## Procedure

Ask the six questions and wait for answers. In a live session ask one at a time, offering the option to answer all six in one message; in an asynchronous context (web/mobile, or a user who is clearly batching) present all six together rather than forcing six round-trips.

1. **Contribution in one sentence.** "If this paper succeeds, what one sentence does it add to the literature?" Reject "contributes to our understanding of X"; push for a specific, falsifiable claim.
2. **Audience and venue.** "Who reads this, and which journal or community is it pitched to?" "It could go anywhere" is a red flag: papers that fit everywhere fit nowhere.
3. **Identification.** "What quantity are you estimating, for whom, and how do you separate it from the obvious confounders?" If observational and the answer is "controls," press for a placebo, instrument, discontinuity, or quasi-experiment; if the answer names a design, ask which assumption it needs and whether the data can test it. "I'll figure it out" means defer the project until the design is concrete.
4. **Falsifiability.** "What pattern in the data would make you abandon the hypothesis?" No answer means the hypothesis will be unfalsifiable on the page too.
5. **Feasibility.** "What is the longest pole (data access, computation, fieldwork, IRB), how long, and what is plan B?" Ask for a concrete timeline.
6. **Scoop risk.** "Has anyone done this in the last 3 years? Is anyone visibly working on it?" Evidence, not "I haven't seen it": SSRN, NBER, and CEPR working papers; OSF and EGAP registrations; APSA, MPSA, EPSA, IPES, and PolMeth programs; NSF award abstracts; the recent volumes of the target journals.

**Verdict**, written with the answers and date to `.mstack/research-question.md`:

- **Green** — all six substantive. Proceed to `/mstack:lit-map`.
- **Yellow** — identification or scoop risk weak. Address the weak link explicitly, then proceed.
- **Red** — two or more answers vague or unsubstantiated. Defer until the gaps close, or run `/mstack:idea-shotgun` for a different angle on the same data.

Do not soften the verdict; if the answers do not justify the project, say so.

## Outputs

- `.mstack/research-question.md` — questions, answers, verdict, date.
- Summary block: verdict + next step.

## Anti-patterns

- **Encouragement before interrogation.**
- **Answering for the user.** If they cannot answer, that is the signal.
- **Skipping questions.** All six, in order.

## Next

Green → `/mstack:lit-map`. Yellow → fix the weak link, re-run. Red → `/mstack:idea-shotgun`, or `/mstack:scope-challenge` if the project may simply be too big.
