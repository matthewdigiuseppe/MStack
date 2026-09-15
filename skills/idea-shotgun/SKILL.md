---
name: idea-shotgun
description: Generates 4-6 genuinely different angles on the same data or topic, carded by claim, contribution, identification, cost, and risk, then ranked. Use when the user has data or a topic but no committed question, wants alternatives before investing, or a red-light verdict sent them back to ideation.
allowed-tools:
  - Bash(date *)
  - Read
  - Write
---

# /mstack:idea-shotgun

**Stage:** ideate · **Voice:** generative

Produces variants so the user picks from a set instead of a hunch.

## Procedure

1. **Load** `.mstack/research-question.md` (if a prior attempt exists) and any data documentation.
2. **Get the seed.** One paragraph from the user: what they have (data, theoretical interest), what the question might be, the audience they imagine.
3. **Generate 4–6 angles**, each varying along one axis:
   - same data, different question;
   - same question, different identification;
   - same identification, different scope (population, time, treatment);
   - same headline, different audience (IPE / comparative / methods / public).
4. **Card each angle:**

   ```
   ANGLE N: <one-sentence claim>
   Contribution:    <the new sentence this adds to the literature>
   Identification:  <how the effect is separated from the obvious confound>
   Cost:            <data-acquire weeks | analysis weeks | total months>
   Risk:            <highest single risk: data, identification, scoop, fit>
   ```

5. **Rank** qualitatively on `(contribution × tractability) / (cost × risk)`; surface the top 2.
6. **Save** every angle, including the unsurfaced ones (next year's paper), to `.mstack/idea-shotgun-<YYYY-MM-DD>.md`.

## Outputs

- `.mstack/idea-shotgun-<date>.md` — full angle set with cards.
- Summary block: top 2 with a one-line case each, and which to take to `/mstack:research-question`.

## Anti-patterns

- **Variations on a theme.** Five angles that swap one variable are not divergence.
- **Defaulting to the seed.** At least one angle should reframe the question entirely.

## Next

`/mstack:research-question` on the chosen angle.
