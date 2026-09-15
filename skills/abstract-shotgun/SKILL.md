---
name: abstract-shotgun
description: Generates 4-6 abstract variants with different positioning bets (puzzle-, policy-, theory-, finding-, anomaly-first), tagged by audience and risk, and recommends one for the target journal. Use when a full draft exists and the user wants the abstract written, improved, or reframed.
allowed-tools:
  - Read
  - Write
  - Edit
---

# /mstack:abstract-shotgun

**Stage:** write · **Voice:** writer, anchored to `voice.writing_style` in `.mstack/config.yaml`

On a full draft. The abstract is the hardest paragraph and the one editors use to desk-reject or send out; generate variants rather than converging on the first.

## Procedure

1. **Load** `paper/sections/intro.tex`, `results.tex`, `discussion.tex`, and `.mstack/config.yaml` (target journals).
2. **Voice:** invoke the `voice.writing_style` skill if set; otherwise clean generic academic prose (short sentences, active verbs, no hedge-stuffing).
3. **Generate 4–6 variants**, each leading differently: **puzzle-first** ("Why does X happen when Y predicts the opposite?"); **policy-first** ("When governments do X, does it work?"); **theory-first** ("We argue that X causes Y because Z"); **finding-first** ("Using a quasi-experiment in X, we find Y"); **anomaly-first** ("Standard accounts predict X; we find Y"); **method-first** (methods papers only).
4. Each ≤ 250 words (or the journal cap if shorter) and contains question, design, finding, contribution; only the order varies.
5. **Tag each** with lead-with style, implicit audience (IPE, comparative, methods, public), and the framing's main risk (e.g. puzzle-first can look unengaged with the literature).
6. **Write the file**, per `format` in `.mstack/config.yaml`. LaTeX: `paper/sections/abstract.tex`, variants as `%` comments, the recommended one uncommented inside `\begin{abstract} … \end{abstract}`. Quarto: `abstract.qmd` with `<!-- … -->` comments.

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

7. **Recommend** the variant that fits the top target journal, justified in one sentence.

## Outputs

- `paper/sections/abstract.tex` — variants as comments, one recommended.
- Summary block: variants with one-line tags + recommendation.

## Anti-patterns

- **Variants that open the same way.** That is not a shotgun.
- **Over the word limit.** If the cap is 200, every variant is ≤ 200.
- **Ignoring the journal.** Some prefer puzzle-first, some finding-first.

## Next

`/mstack:title-shotgun` to pair a title with the chosen framing. `/mstack:draft-section abstract` gives a baseline beforehand.
