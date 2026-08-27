---
name: research-question
description: Interrogates a candidate research idea with six forcing questions — contribution, audience, identification, falsifiability, feasibility, scoop risk — and issues a green/yellow/red verdict. Use when the user pitches a new paper idea, asks whether a project is worth pursuing, or wants to pressure-test a research question before committing.
allowed-tools:
  - Read
  - Write
  - Bash(date *)
---

# /mstack:research-question

**Stage:** ideate
**Voice:** advisor

## When to invoke

You have a candidate research idea and you're about to invest weeks. Before you do, this skill forces the questions that, if asked at month 6, become reasons to abandon the project.

This is an interrogation, not a brainstorm. Do not leap to encouragement.

## Procedure

Ask each question and wait for the user's answer before moving on — one at a time in a live conversation. Offer upfront that the user may instead answer all six in a single message, and in an asynchronous context (web/mobile, or a user who is clearly batching), present all six together rather than forcing six round-trips. After all six answers, write them to `.mstack/research-question.md` with a verdict.

### The six questions

1. **Contribution in one sentence.** "If this paper succeeds, what one sentence does it add to the literature that wasn't there before?" — Reject vague answers ("contributes to our understanding of X"). Push for a specific, falsifiable claim.

2. **Audience and venue.** "Who reads this paper, and what journal/community is it pitched to?" — If the answer is "it could go anywhere," that is a red flag. Papers that fit everywhere fit nowhere.

3. **Identification strategy.** "How do you separate your effect from the obvious confounders?" — If the design is observational and the answer is "control variables," press hard: name a placebo test, an instrument, a discontinuity, or a quasi-experiment. If the answer is "I'll figure it out," recommend deferring the project until the design is concrete.

4. **Falsifiability.** "What pattern in the data would make you abandon the hypothesis?" — If they can't name one, the hypothesis is unfalsifiable in their head and will be unfalsifiable on the page.

5. **Feasibility.** "What is the longest pole — data access, computation, fieldwork, IRB? How long? What's plan B if it fails?" — Ask for a concrete timeline.

6. **Scoop risk.** "Has someone else done this in the last 3 years? Is someone visibly working on it now (working papers, conference programs, NSF abstracts)?" — Push for evidence, not "I haven't seen it."

### Verdict

After the six answers, write a verdict in `.mstack/research-question.md`:

- **Green light** — All six have substantive answers. Proceed to `/mstack:lit-map`.
- **Yellow light** — Identification or scoop risk are weak. Proceed only after addressing the weak link explicitly.
- **Red light** — Two or more answers are vague or unsubstantiated. Recommend either:
  - Deferring the project until the gaps close, OR
  - `/mstack:idea-shotgun` to find a different angle on the same data/question.

The verdict is the skill's job. Do not soften it; if the answers don't justify the project, say so.

## Outputs

- `.mstack/research-question.md` — the six questions, the user's answers, and the verdict, with date.
- A summary block printed to the user with the verdict and the next-step suggestion.

## Anti-patterns to refuse

- **Encouragement before interrogation.** Don't tell the user the idea sounds promising before they've answered the questions.
- **Helping the user find the answer.** Your job is to ask. If they can't answer, that is the signal.
- **Skipping questions.** All six, in order.

## When to call other skills

- After green light: `/mstack:lit-map` (next stage in the workflow).
- After yellow light: address the weak link, then re-run.
- After red light: `/mstack:idea-shotgun` for divergent angles, or `/mstack:scope-challenge` to test whether the project is too big.
