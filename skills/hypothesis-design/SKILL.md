---
name: hypothesis-design
description: Operationalizes hypotheses, runs a falsifiability check, pre-commits to direction. Use after /theory-build and before any data analysis. Writes to .mstack/hypotheses.md.
user-invocable: true
allowed-tools:
  - Read
  - Write
---

# /mstack:hypothesis-design

**Stage:** map
**Voice:** methodologist

## When to invoke

After `/theory-build`. Before fielding or analyzing. Before `/preregister` (the prereg quotes these hypotheses).

## Procedure

1. **Load.** `.mstack/theory.md`, `.mstack/lit-map.md`.

2. **For each hypothesis (H1, H2, …), specify all six fields:**

   | Field | Example |
   |---|---|
   | **Statement** | "Higher exposure to import competition increases vote share for protectionist parties." |
   | **Direction** | Positive (β > 0). |
   | **Effect-size sign + magnitude expectation** | "We expect a 1-SD increase in exposure to raise vote share by 1–3 percentage points." |
   | **Operationalization of X** | "Exposure = ADH-style instrument constructed as in Autor et al. 2013, country-region-year level." |
   | **Operationalization of Y** | "Vote share = percent of constituency vote for parties classified as protectionist by CMP." |
   | **Falsification pattern** | "A null result (β CI overlapping zero) at the country-region-year level falsifies H1. A negative coefficient (β < 0) falsifies the mechanism direction." |

3. **Falsifiability check.** For each hypothesis:
   - Could a result actually falsify it, or is the prediction "X has *some* relationship with Y"? Reject vague directions.
   - Is the falsification pattern observable with the planned data? If the data can't produce the falsifying pattern, the hypothesis is unfalsifiable in this design.

4. **Primary vs. secondary.** Mark exactly one hypothesis as **primary**. The primary is what the paper's headline rests on. Secondaries explore mechanism, heterogeneity, or scope but don't carry the headline.

5. **Heterogeneity / moderation.** If moderation is theorized, specify it as its own hypothesis (e.g., "H2: The effect of X on Y is larger in subset S because Z"). Heterogeneity tests not pre-specified here are exploratory in the prereg.

6. **Save** to `.mstack/hypotheses.md`. The prereg pulls from this file.

## Outputs

- `.mstack/hypotheses.md` — H1, H2, … with all six fields plus primary/secondary marker.
- Summary block: primary hypothesis sentence + falsification pattern.

## Anti-patterns to refuse

- **One-sided ambiguity.** "We expect X to be related to Y" is not a hypothesis.
- **Hypotheses bigger than the data.** If your data can't observe the falsifying pattern, the hypothesis can't be tested here. Either get different data or rewrite the hypothesis.
- **Five primaries.** Exactly one. The rest are secondaries.

## When to call other skills

- After: `/identification-review`, then `/preregister`.
