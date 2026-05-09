---
name: abstract-shotgun
description: Generates 4–6 abstract variants with different positioning bets. Use after a complete draft to find the best framing before submission. Writes variants to paper/sections/abstract.tex as commented options.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
---

# /mstack:abstract-shotgun

**Stage:** write
**Voice:** writer (anchored to `digiuseppe-writing-style`)

## When to invoke

The full draft exists. The abstract is the single hardest paragraph in the paper, and the most decision-relevant for editors deciding desk-reject or send-out. Generate variants instead of converging on the first one.

## Procedure

1. **Load.** `paper/sections/intro.tex`, `paper/sections/discussion.tex`, `paper/sections/results.tex`, `.mstack/config.yaml` (target journals).

2. **Use digiuseppe-writing-style** for voice across all variants.

3. **Generate 4–6 variants**, each varying along one of:

   | Variant | What it leads with |
   |---|---|
   | **Puzzle-first** | Opens with an empirical or theoretical puzzle. "Why does X happen when Y predicts the opposite?" |
   | **Policy-first** | Opens with the policy / real-world stake. "When governments do X, does it work?" |
   | **Theory-first** | Opens with the theoretical claim. "We argue that X causes Y because Z." |
   | **Finding-first** | Opens with the headline result. "Using a quasi-experiment in X, we find that Y." |
   | **Anomaly-first** | Opens with what the literature predicts vs. what we find. "Standard accounts predict X; we find Y." |
   | **Method-first** (only for methods papers) | Opens with the methodological contribution. |

4. **Each variant is ≤ 250 words** (or the journal limit if shorter). Each contains: question, design, finding, contribution. The order is what varies.

5. **Tag each variant** with:
   - Lead-with style.
   - Implicit audience (IPE, comparative, methods, public).
   - Risk: the framing's main vulnerability (e.g., "puzzle-first risks looking like it doesn't engage the literature").

6. **Write to `paper/sections/abstract.tex`** with all variants as LaTeX comments and one designated `\begin{abstract} ... \end{abstract}` block containing the recommended variant. Format:

   ```
   % VARIANT 1 (puzzle-first):
   % <text>
   %
   % VARIANT 2 (policy-first):
   % <text>
   ...

   % --- RECOMMENDED ---
   <recommended variant text, uncommented>
   ```

7. **Recommend.** State which variant best fits the top target journal in `.mstack/config.yaml`. Justify in one sentence.

## Outputs

- `paper/sections/abstract.tex` — variants as comments + one recommended uncommented.
- Summary block: 4–6 variants with one-line tags + recommendation.

## Anti-patterns to refuse

- **Variants that all open the same way.** That's not a shotgun.
- **Going over the word limit.** If the limit is 200, all variants are ≤ 200.
- **Ignoring the journal.** Some journals prefer puzzle-first; some prefer finding-first. The recommendation considers the target.

## When to call other skills

- Before: `/draft-section abstract` (to get a baseline).
- After: `/title-shotgun` to find a title that pairs with the chosen abstract framing.
