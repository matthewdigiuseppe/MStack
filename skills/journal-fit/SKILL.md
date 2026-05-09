---
name: journal-fit
description: Picks 3 target journals and produces a comparison table on impact × fit × turnaround × desk-reject risk. Use when the paper is submission-ready. Updates .mstack/config.yaml with the tier.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - WebFetch
  - WebSearch
---

# /mstack:journal-fit

**Stage:** submit
**Voice:** editor

## When to invoke

The manuscript is submission-ready (passed `/results-audit`, `/coauthor-review`, `/referee-mock`). You need to pick a journal — and a backup, and a backup's backup.

## Procedure

1. **Load.** Abstract from `paper/sections/abstract.tex`, contribution from `.mstack/research-question.md`, lit-positioning from `.mstack/lit-map.md`.

2. **Generate a candidate set of 6–8 journals.** Mix of:
   - Aspirational (top-tier general: APSR, AJPS, JOP / IO, BJPS).
   - Aspirational field (top-tier IPE / IR / comparative).
   - Realistic field (mid-tier with good fit).
   - Specialty (a journal where the topic is core).
   - Backup (publishes well, lower desk-reject risk).

3. **For each candidate, score on a fixed grid.** Use WebSearch / WebFetch to look up recent volumes if helpful (look for: published papers similar to the user's; word limits; review timelines).

   | Dimension | Scale | Notes |
   |---|---|---|
   | Impact | 1–5 | Generalist / specialist matters; cite-count is a noisy proxy. |
   | Fit (recent papers in this conversation) | 1–5 | If the journal hasn't published in this conversation in 5 years, fit is low. |
   | Editor receptivity to method | 1–5 | Some journals reject quasi-experimental on principle; some prefer it. |
   | Word limit fit | 1–5 | Does the paper's actual length fit the journal's hard cap? |
   | Review turnaround | 1–5 | Median time from submission to first decision (use journal's posted data when available). |
   | Desk-reject risk | 1–5 (5 = low risk) | Editor's stated criteria for desk reject. |
   | Open-access / data policy | note | Does it require pre-acceptance OA? Restricted-data policy? |

4. **Tier the top 3.**
   - **Reach** — highest impact among candidates with fit ≥ 3.
   - **Realistic** — highest fit × low desk-reject risk × decent impact.
   - **Backup** — high probability of acceptance; preserves time-to-publication.

5. **Write the comparison table** to `.mstack/journal-fit-<YYYY-MM-DD>.md`.

6. **Update `.mstack/config.yaml`'s `target_journals`** with the three tiers.

7. **Recommend** the submission journal. Justify in two sentences. Tie it to the abstract framing chosen in `/abstract-shotgun`.

## Outputs

- `.mstack/journal-fit-<date>.md` — full comparison table.
- `.mstack/config.yaml` — `target_journals` populated.
- Summary block: 3-tier choice with one-line justification per tier + recommended submission journal.

## Anti-patterns to refuse

- **One-tier strategy.** Always have a Reach, Realistic, Backup — research is too long to optimize on one journal.
- **Impact-only ranking.** A 5/5 impact journal with 1/5 fit has zero expected value.
- **Skipping desk-reject risk.** A high-impact journal that desk-rejects in two days costs zero review time but the user must know the risk going in.

## When to call other skills

- Before: `/referee-mock editor` to stress-test fit.
- After: `/cover-letter` for the chosen journal.
