---
name: theory-build
description: Builds the causal mechanism (X causes Y because Z), a signed ASCII DAG, scope conditions, and out-of-sample predictions. Use after the lit map, when the user wants to formalize a theory or mechanism, sketch a DAG, or derive predictions — before hypotheses are operationalized.
allowed-tools:
  - Read
  - Write
  - Edit
---

# /mstack:theory-build

**Stage:** map · **Voice:** theorist

After `/mstack:lit-map`, before `/mstack:hypothesis-design`, so hypotheses derive from a stated mechanism rather than being retrofitted to results.

## Procedure

1. **Load** `.mstack/research-question.md` and `.mstack/lit-map.md`.
2. **Mechanism in one sentence:** "X causes Y because Z." Ask until the user can say it; it is the spine of the paper.
3. **DAG (ASCII).** Nodes: treatment / IV, outcome, mediators (M1, M2, …), pre-treatment confounders (W1, W2, …), post-treatment colliders (C1, …) flagged explicitly, since controlling on one is a common error. Every edge signed, with a one-line justification.
4. **Scope conditions**, one or two sentences each, as their own labeled list in the file:
   - **Population** — for whom should this hold?
   - **Time** — what era?
   - **Institutional** — what kind of state, regime, market?
   - **Boundary** — where would you expect the mechanism to break?
5. **Implications.** At least two predictions for cases or observations outside the proposed sample; these off-the-line predictions separate a theory from a story tuned to the data.
6. **Compatibility with the lit map**, as its own section:
   - which Foundation papers the mechanism builds on;
   - which Frontier papers it disputes;
   - where it stands on the contested edge of the conversation.
7. **Save** to `.mstack/theory.md`. Optionally stub `paper/sections/theory.tex` with the mechanism sentence and scope conditions; full drafting is `/mstack:draft-section theory`.

## Outputs

- `.mstack/theory.md` — mechanism, DAG, scope, predictions, positioning.
- Optional stub `paper/sections/theory.tex`.
- Summary block: mechanism sentence + the off-the-line prediction most likely to falsify.

## Anti-patterns

- **Mechanism by association.** "X correlates with Y, and Y matters for Z" is not a mechanism.
- **Unsigned edges.** No signs, no directed model.
- **Universal scope.** "Everywhere, always" predicts nothing.

## Next

`/mstack:hypothesis-design`, then `/mstack:identification-review`.
