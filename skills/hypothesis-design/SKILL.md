---
name: hypothesis-design
description: Turns theory into operationalized, falsifiable hypotheses — statement, direction, magnitude, X/Y operationalization, falsification pattern — with exactly one primary. Use before any data collection, analysis, or preregistration, or whenever the user drafts or revises hypotheses.
allowed-tools:
  - Read
  - Write
---

# /mstack:hypothesis-design

**Stage:** map · **Voice:** methodologist

After `/mstack:theory-build`; before fielding, analysis, or `/mstack:preregister` (which quotes these hypotheses).

## Procedure

1. **Load** `.mstack/theory.md` and `.mstack/lit-map.md`.
2. **Specify six fields per hypothesis** (H1, H2, …):

   | Field | Example |
   |---|---|
   | Statement | "Higher exposure to import competition increases vote share for protectionist parties." |
   | Direction | Positive (β > 0). |
   | Magnitude expectation | "A 1-SD increase in exposure raises vote share by 1–3 percentage points." |
   | Operationalization of X | "ADH-style instrument as in Autor et al. 2013, country-region-year level." |
   | Operationalization of Y | "Percent of constituency vote for parties CMP classifies as protectionist." |
   | Falsification pattern | "A CI overlapping zero falsifies H1; β < 0 falsifies the mechanism direction." |

3. **Falsifiability check.** Could a result actually falsify it, or is the prediction "some relationship"? Is the falsifying pattern observable with the planned data? If not, the hypothesis is untestable in this design.
4. **Exactly one primary.** The headline rests on it; secondaries explore mechanism, heterogeneity, or scope.
5. **Moderation**, if theorized, is its own hypothesis ("H2: the effect of X on Y is larger in S because Z"). Heterogeneity not specified here is exploratory in the prereg.
6. **Save** to `.mstack/hypotheses.md`; the prereg pulls from it.

## Outputs

- `.mstack/hypotheses.md` — every hypothesis with all six fields and the primary marked.
- Summary block: primary hypothesis + its falsification pattern.

## Anti-patterns

- **One-sided ambiguity.** "X is related to Y" is not a hypothesis.
- **Hypotheses bigger than the data.** If the data cannot show the falsifying pattern, get different data or rewrite the hypothesis.
- **Five primaries.** Exactly one.

## Next

`/mstack:identification-review`, then `/mstack:preregister`.
