---
name: idea-shotgun
description: Generates 4-6 genuinely different angles on the same data or topic — each with claim, contribution, identification sketch, cost, and risk — then ranks them. Use when the user has data or a topic but no committed question, wants alternatives before investing, or a red-light verdict sent them back to ideation.
allowed-tools:
  - Bash(date *)
  - Read
  - Write
---

# /mstack:idea-shotgun

**Stage:** ideate
**Voice:** generative

## When to invoke

You have data, a topic, or an unanswered question — and you're not yet committed to a specific angle. The shotgun produces variants so you pick from a set instead of from a hunch.

## Procedure

1. **Load context.** Read any `.mstack/research-question.md` (if a prior attempt exists) and the data documentation if applicable.

2. **Ask the user for the seed.** One paragraph: what they have (data, theoretical interest), what they think the question might be, and what audience they imagine.

3. **Generate 4–6 angles.** Each must vary along one of:
   - **Same data, different question.**
   - **Same question, different identification.**
   - **Same identification, different scope (population, time, treatment).**
   - **Same headline, different audience (IPE / comparative / methods / public).**

4. **Score each angle on a 4-cell card:**

   ```
   ANGLE N: <one-sentence claim>
   --------
   Contribution:    <one sentence — what new sentence this adds to the literature>
   Identification:  <one sentence — how to separate the effect from the obvious confound>
   Cost:            <data-acquire weeks | analysis weeks | total months>
   Risk:            <highest single risk: data, identification, scoop, fit>
   ```

5. **Rank.** Score each on `(contribution × tractability) / (cost × risk)` qualitatively. Surface the top 2 to the user.

6. **Save** to `.mstack/idea-shotgun-<YYYY-MM-DD>.md` with all angles, including the ones not surfaced — they may be next year's paper.

## Outputs

- `.mstack/idea-shotgun-<date>.md` — full angle set with cards.
- Summary block: top 2 angles with a one-line case for each, and a recommendation on which to take to `/mstack:research-question`.

## Anti-patterns to refuse

- **Variations on a theme.** If five angles are all "the same question with one variable swapped," that's not divergence. Push for genuinely different framings.
- **Defaulting to the user's seed.** The shotgun is most valuable when at least one angle reframes the question entirely.

## When to call other skills

- After: `/mstack:research-question` on the chosen angle.
