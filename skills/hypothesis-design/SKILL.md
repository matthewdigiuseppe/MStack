---
name: hypothesis-design
description: Turns theory into operationalized, falsifiable hypotheses — statement, direction, estimand, smallest effect of substantive interest, X/Y operationalization, falsification pattern, and what a null would mean — with exactly one marked primary. Use before any data collection, analysis, or preregistration, or whenever the user drafts or revises hypotheses.
allowed-tools:
  - Read
  - Write
---

# /mstack:hypothesis-design

**Stage:** map · **Voice:** methodologist

After `/mstack:theory-build`; before fielding, analysis, or `/mstack:preregister` (which quotes these hypotheses verbatim). The bar is the one the preregistration will be held to: two researchers given the hypothesis and the data should test the same thing (see `${CLAUDE_PLUGIN_ROOT}/references/preregistration-guide.md`, section "What must be specific").

## Procedure

1. **Load** `.mstack/theory.md` (mechanism, rivals, estimand) and `.mstack/lit-map.md` (comparable effect sizes).
2. **Specify eight fields per hypothesis** (H1, H2, …):

   | Field | Example |
   |---|---|
   | Statement | "Higher exposure to import competition increases vote share for protectionist parties." |
   | Direction | Positive (β > 0). |
   | Estimand | "The ATT of a one-SD increase in exposure on protectionist vote share (percentage points), among NUTS-2 regions in 12 EU states, 2000–2019" (Lundberg, Johnson & Stewart 2021). |
   | Magnitude expectation | "A 1-SD increase in exposure raises vote share by 1–3 percentage points; comparable estimates in Colantone & Stanig (2018) are …" |
   | Smallest effect of substantive interest | "1 percentage point; smaller effects would not change the policy or theoretical claim." |
   | Operationalization of X | "ADH-style instrument as in Autor et al. 2013, country-region-year level." |
   | Operationalization of Y | "Percent of constituency vote for parties CMP classifies as protectionist." |
   | Falsification pattern and null reading | "A 95% CI excluding zero supports H1; a CI entirely within (−1, 1) is evidence against a substantively meaningful effect; a CI straddling both is inconclusive. β < 0 falsifies the mechanism direction." |

3. **Falsifiability check.** Could a result actually falsify it, or is the prediction "some relationship"? Is the falsifying pattern observable with the planned data at the planned N (check against `.mstack/power-analysis.md` once it exists)? If not, the hypothesis is untestable in this design.
4. **Exactly one primary.** The headline rests on it; secondaries explore mechanism, heterogeneity, or scope. Every secondary carries the same eight fields.
5. **Moderation and mechanism.** A theorized moderator is its own hypothesis stating the marginal effect of X at each level of the moderator, not the interaction coefficient ("H2: the effect of X on Y is at least twice as large where S is high as where S is low"); a theorized mediator is a hypothesis about the path, with the caveat that mediation analysis needs its own identifying assumptions. Heterogeneity not specified here is exploratory in the prereg. Take the rows of the rival-mechanisms table in `theory.md` and write, for each, the hypothesis that would distinguish your mechanism from that rival.
6. **Save** to `.mstack/hypotheses.md`; the prereg pulls from it.

## Outputs

- `.mstack/hypotheses.md` — every hypothesis with all eight fields, the primary marked, and the rival-discriminating hypotheses grouped at the end.
- Summary block: primary hypothesis, its estimand, its SESOI, and its falsification pattern.

## Anti-patterns

- **One-sided ambiguity.** "X is related to Y" is not a hypothesis.
- **No estimand.** "The coefficient on X" is not a quantity about the world.
- **Hypotheses bigger than the data.** If the data cannot show the falsifying pattern, get different data or rewrite the hypothesis.
- **Five primaries.** Exactly one.
- **A null with no interpretation.** Decide now what a null result will be taken to mean.

## Next

`/mstack:identification-review`, then `/mstack:preregister`.
