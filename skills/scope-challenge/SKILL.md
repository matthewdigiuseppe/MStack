---
name: scope-challenge
description: Adversarial advisor voice that challenges scope. "Is this a paper or a footnote?" "Is this one paper or three?" Use when a project is sprawling or you suspect you're writing a book chapter, not a journal article. Analog to gstack's /plan-ceo-review.
user-invocable: true
allowed-tools:
  - Read
  - Write
---

# /mstack:scope-challenge

**Stage:** ideate
**Voice:** adversarial-advisor

## When to invoke

The project is growing. You have three figures that are each interesting and you can't tell which is the headline. You've added a new section every week for a month. You suspect this is two papers, or a book chapter, or an unfinishable thing.

## Procedure

Read `.mstack/research-question.md`, `.mstack/lit-map.md`, and any draft sections that exist. Then run the four challenges, in order. Write the results to `.mstack/scope-challenge-<YYYY-MM-DD>.md`.

### Challenge 1: One sentence
"State the paper's contribution in one sentence with no clauses." If the user can't, the scope is wrong. Push until they can.

### Challenge 2: One table
"Which single table is the paper? Which figure is the cover?" Papers in IPE / political science journals are built around 1–2 tables and 1–2 figures. If the user names four "essential" tables, two of them belong in another paper or an appendix.

### Challenge 3: Cleavage test
"If you had to split this into two papers, where would the cut go?" The exercise of finding the cut often reveals that one is a paper and one is a sketch. The sketch is for later.

### Challenge 4: 3-month ship
"What would you cut if you had to submit in 3 months?" The list of cuts is usually a list of things that should already be cut. Build the minimum viable paper.

### Verdict

Write a short summary:

- **Tight** — the project survives all four challenges. Continue as is.
- **Sprawl** — one or more challenges fail. Recommend a specific cut: a section, a table, an analysis branch.
- **Multi-paper** — the cleavage test reveals two distinct contributions. Recommend splitting and which half is paper one.

The verdict is opinionated by design. Soft verdicts produce sprawling papers.

## Outputs

- `.mstack/scope-challenge-<date>.md` — challenges, answers, verdict.
- Summary block: verdict + the single most important cut.

## Anti-patterns to refuse

- **Affirming a 60-page draft.** If the user describes a project that doesn't fit a journal article, say so.
- **"Both papers are great."** Pick one. The other is for next year.

## When to call other skills

- After `Sprawl` verdict: re-run `/research-question` for the trimmed project.
- After `Multi-paper` verdict: `mstack-init` a new sibling folder for the second paper.
