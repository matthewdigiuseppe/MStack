---
name: theory-build
description: Builds the formal mechanism, sketches a DAG, specifies scope conditions. Use after /lit-map identifies the conversation and before /hypothesis-design operationalizes. Writes to .mstack/theory.md and feeds paper/sections/theory.tex.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
---

# /mstack:theory-build

**Stage:** map
**Voice:** theorist

## When to invoke

After `/lit-map` so you know the conversation. Before `/hypothesis-design` so the hypotheses are derived from a stated mechanism, not retrofitted to results.

## Procedure

1. **Load.** `.mstack/research-question.md` and `.mstack/lit-map.md`.

2. **State the mechanism in one sentence.** "X causes Y because Z." If the user can't, ask until they can. The sentence is the spine of the paper.

3. **Draw the DAG (in prose / ASCII).** Nodes:
   - The treatment / IV.
   - The outcome.
   - Mediators (M1, M2, …).
   - Pre-treatment confounders (W1, W2, …).
   - Post-treatment colliders (C1, …) — flag these explicitly; controlling on a collider is a common error.

   Edges with sign and a one-line justification per edge.

   Save the DAG to `.mstack/theory.md` as ASCII; the user can rebuild it as a figure later.

4. **Scope conditions.** Three to five sentences:
   - **Population scope** — for whom should this hold?
   - **Time scope** — what era?
   - **Institutional scope** — what kind of state, regime, market?
   - **Boundary** — where would you expect the mechanism to break?

5. **Implications.** What does this theory predict for cases / observations not in the data? At least two predictions outside the proposed sample. These are the "off-the-line" predictions that distinguish a real theory from a story tuned to the data.

6. **Compatibility check** with `/lit-map`:
   - Which Foundation paper(s) does the mechanism build on?
   - Which Frontier paper(s) does it dispute?
   - Where does the theory stand on the contested edge of the conversation?

7. **Save** the full theory to `.mstack/theory.md`. Optionally stub `paper/sections/theory.tex` with the mechanism sentence + scope conditions; full drafting later via `/draft-section theory`.

## Outputs

- `.mstack/theory.md` — mechanism, DAG, scope, predictions, lit-positioning.
- (Optional) stubbed `paper/sections/theory.tex`.
- Summary block: mechanism sentence + the one off-the-line prediction most likely to falsify.

## Anti-patterns to refuse

- **Mechanism by association.** "X is correlated with Y, and theoretically Y matters for Z" is not a mechanism.
- **DAGs without arrows.** If you can't sign the edges, you don't have a directed model.
- **Universal scope.** "This holds everywhere, always" predicts nothing.

## When to call other skills

- After: `/hypothesis-design` to operationalize, then `/identification-review` to stress-test the implied design.
