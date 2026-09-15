---
name: theory-build
description: Builds the causal mechanism (X causes Y because Z) with its steps and assumptions, a signed ASCII DAG, scope conditions, the rival mechanisms and the observable implications that separate them, out-of-sample predictions, and the estimand the theory speaks to. Use after the lit map, when the user wants to formalize a theory or mechanism, sketch a DAG, or derive predictions — before hypotheses are operationalized.
allowed-tools:
  - Read
  - Write
  - Edit
  - Grep
  - Glob
---

# /mstack:theory-build

**Stage:** map · **Voice:** theorist

After `/mstack:lit-map`, before `/mstack:hypothesis-design`, so hypotheses derive from a stated mechanism rather than being retrofitted to results. The output is the memo every later stage tests against: the identification review prosecutes its DAG, the robustness plan tests its rivals, the discussion section answers its scope conditions.

## Procedure

1. **Load** `.mstack/research-question.md` and `.mstack/lit-map.md`. When a Foundation or Frontier paper's actual argument matters, read its converted section in `lit/md/` (the `sections` list in each file's front matter is the map) rather than working from the abstract.
2. **Mechanism in one sentence:** "X causes Y because Z." Then unpack Z into steps: who does what, in response to what, at which point in time, and what each step assumes (information, incentives, capacity, institutions). Ask until the user can say the sentence; it is the spine of the paper, and a mechanism that cannot be stated in one sentence is usually two mechanisms or none.
3. **DAG (ASCII).** Nodes: treatment / IV, outcome, mediators (M1, M2, …), pre-treatment confounders (W1, W2, …), post-treatment colliders and consequences (C1, …) flagged explicitly with a do-not-condition note, since controlling on one is a common error (Elwert & Winship 2014; Montgomery, Nyhan & Torres 2018). Every edge signed, with a one-line justification in an edge table. Feedback over time is drawn as two nodes (X_t, X_t+1), never as a cycle.
4. **Scope conditions**, one or two sentences each, as their own labeled list in the file:
   - **Population** — for whom should this hold?
   - **Time** — what era, and why the mechanism needs it?
   - **Institutional** — what kind of state, regime, market, or organization?
   - **Boundary** — where would you expect the mechanism to break, and what would breaking look like?
5. **Rival mechanisms.** List the two to four mechanisms that would produce the same headline correlation (the reverse-causal story, a common cause, an alternative channel, the "neutral pipe" version in which your Z plays no role), and for each the observable implication that separates it from yours: a subgroup where the rival predicts an effect and you do not, a timing pattern, a placebo outcome, a dose-response shape. Put it in a table; `/mstack:identification-review` and `/mstack:robustness` test these rows.
6. **Implications.** At least two predictions for cases or observations outside the proposed sample (another country, period, policy, or shock), each with what the finding would look like; these off-the-line predictions separate a theory from a story tuned to the data. Keep in-sample mechanism tests (mediators, heterogeneity) in a separate list, labeled as such.
7. **Estimand.** State the quantity the theory speaks to: an average effect in a population, the effect among the exposed, the effect at a margin or cutoff, an effect that varies with a moderator. `/mstack:hypothesis-design` carries it into each hypothesis (Lundberg, Johnson & Stewart 2021).
8. **Compatibility with the lit map**, as its own section:
   - which Foundation papers the mechanism builds on;
   - which Frontier papers it disputes, and on what observable point;
   - where it stands on the contested edge of the conversation.
9. **Check before saving:** the graph is acyclic; every edge has a sign and a justification; the time scope matches the sample window in the research question; each off-the-line prediction lies outside the sample's population, period, or geography, and any that does not is relabeled an in-sample test; each rival mechanism has an observable implication that is not also implied by your mechanism.
10. **Save** to `.mstack/theory.md`. Optionally stub `paper/sections/theory.tex` with the mechanism sentence and scope conditions; full drafting is `/mstack:draft-section theory`.

## Outputs

- `.mstack/theory.md` — mechanism and steps, DAG with edge table, scope conditions, rival mechanisms table, predictions, estimand, positioning.
- Optional stub `paper/sections/theory.tex`.
- Summary block: mechanism sentence, the rival most likely to be raised by a reviewer and the test that separates it, and the off-the-line prediction most likely to falsify.

## Anti-patterns

- **Mechanism by association.** "X correlates with Y, and Y matters for Z" is not a mechanism.
- **Unsigned edges.** No signs, no directed model.
- **Universal scope.** "Everywhere, always" predicts nothing.
- **No rivals.** A theory that has never been compared with the reverse-causal story has not been tested against anything.
- **A theory that predicts everything.** If no outcome would embarrass it, it is not a theory.

## Next

`/mstack:hypothesis-design`, then `/mstack:identification-review`.
