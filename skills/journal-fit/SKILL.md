---
name: journal-fit
description: Scores 6-8 candidate journals on impact, fit, method receptivity, word limits, turnaround, and desk-reject risk, then sets a reach/realistic/backup tier in config. Use when the user asks where to submit or which journal fits the paper.
allowed-tools:
  - Bash(date *)
  - Read
  - Write
  - Edit
  - WebFetch
  - WebSearch
---

# /mstack:journal-fit

**Stage:** submit · **Voice:** editor

When the manuscript has passed `/mstack:results-audit`, `/mstack:coauthor-review`, and `/mstack:referee-mock`. Pick a journal, a backup, and the backup's backup.

## Procedure

1. **Load** the abstract (`paper/sections/abstract.tex`), the contribution (`.mstack/research-question.md`), the positioning (`.mstack/lit-map.md`).
2. **Candidate set of 6–8:** aspirational general (APSR, AJPS, JOP / IO, BJPS); aspirational field (top IPE / IR / comparative); realistic field with good fit; a specialty journal where the topic is core; a backup that publishes well with low desk-reject risk.
3. **Score each** (WebSearch / WebFetch recent volumes for similar papers, word limits, review timelines):

   | Dimension | Scale | Note |
   |---|---|---|
   | Impact | 1–5 | Generalist vs. specialist matters; cite counts are a noisy proxy |
   | Fit | 1–5 | Nothing in this conversation in 5 years = low |
   | Editor receptivity to method | 1–5 | Some reject quasi-experimental work on principle; some prefer it |
   | Word-limit fit | 1–5 | Actual length vs. the hard cap |
   | Review turnaround | 1–5 | Median to first decision, from posted data when available |
   | Desk-reject risk | 1–5 (5 = low) | Editor's stated criteria |
   | OA / data policy | note | Pre-acceptance OA? Restricted-data policy? |

4. **Tier the top 3:** **Reach** (highest impact with fit ≥ 3), **Realistic** (highest fit × low desk-reject risk × decent impact), **Backup** (high acceptance probability; preserves time-to-publication).
5. **Write** the comparison table to `.mstack/journal-fit-<YYYY-MM-DD>.md` and set `target_journals` in `.mstack/config.yaml` to the three tiers.
6. **Recommend** the submission journal in two sentences, tied to the abstract framing chosen in `/mstack:abstract-shotgun`.

## Outputs

- `.mstack/journal-fit-<date>.md`; `.mstack/config.yaml` (`target_journals`).
- Summary block: three tiers with one-line justifications + the recommended journal.

## Anti-patterns

- **One-tier strategy.** Always reach, realistic, backup; research is too long to bet on one journal.
- **Impact-only ranking.** 5/5 impact with 1/5 fit has zero expected value.
- **Ignoring desk-reject risk.** The user must know it going in.

## Next

`/mstack:submission-pack`, then `/mstack:cover-letter` for the chosen journal. `/mstack:referee-mock editor` beforehand stress-tests fit.
