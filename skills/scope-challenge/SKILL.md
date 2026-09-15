---
name: scope-challenge
description: Adversarial scope check — is this a paper, a footnote, or three papers? Four challenges force the contribution into one sentence and one table. Use when a project is sprawling, sections keep multiplying, the user cannot name the headline result, or asks whether to split a paper.
allowed-tools:
  - Bash(date *)
  - Read
  - Write
---

# /mstack:scope-challenge

**Stage:** ideate · **Voice:** adversarial-advisor

For the project that keeps growing: three interesting figures and no headline, a new section every week, a suspicion that this is two papers or an unfinishable one.

## Procedure

Read `.mstack/research-question.md`, `.mstack/lit-map.md`, and any draft sections. Run the four challenges in order; write the results to `.mstack/scope-challenge-<YYYY-MM-DD>.md`.

1. **One sentence.** "State the contribution in one sentence with no clauses." If the user cannot, the scope is wrong; push until they can.
2. **One table.** "Which single table is the paper? Which figure is the cover?" Political science papers are built around 1–2 tables and 1–2 figures; four "essential" tables means two belong in another paper or an appendix.
3. **Cleavage test.** "If you had to split this into two papers, where is the cut?" Finding the cut usually reveals one paper and one sketch. The sketch is for later.
4. **3-month ship.** "What would you cut to submit in 3 months?" That list is usually what should already be cut. Build the minimum viable paper.

**Verdict:**

- **Tight** — survives all four. Continue as is.
- **Sprawl** — one or more fail. Recommend a specific cut: a section, a table, an analysis branch.
- **Multi-paper** — the cleavage test reveals two contributions. Recommend the split and which half is paper one.

Soft verdicts produce sprawling papers; be opinionated.

## Outputs

- `.mstack/scope-challenge-<date>.md` — challenges, answers, verdict.
- Summary block: verdict + the single most important cut.

## Anti-patterns

- **Affirming a 60-page draft.** If it does not fit a journal article, say so.
- **"Both papers are great."** Pick one; the other is next year's.

## Next

Sprawl → re-run `/mstack:research-question` on the trimmed project. Multi-paper → `/mstack:mstack-init` a sibling folder for paper two.
