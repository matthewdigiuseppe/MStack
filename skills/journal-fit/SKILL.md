---
name: journal-fit
description: Scores 6-8 candidate journals drawn from the discipline's outlets by subfield on impact, fit with the paper's conversation, method receptivity, word limits, turnaround, replication and open-access policies, and desk-reject risk, then sets a reach/realistic/backup tier in config. Use when the user asks where to submit or which journal fits the paper.
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

1. **Load** the abstract (`paper/sections/abstract.tex`), the contribution (`.mstack/research-question.md`), the positioning (`.mstack/lit-map.md`, especially where the Foundation and Frontier papers were published), the design (`.mstack/config.yaml` → `design.type`), and `${CLAUDE_PLUGIN_ROOT}/references/journals.md`.
2. **Candidate set of 6–8** from the reference, by subfield: aspirational general (APSR, AJPS, JOP, BJPS); aspirational field (IO, ISQ, World Politics, CPS as the subfield dictates); realistic field with good fit; a specialty journal where the topic is core; a short-format outlet if the paper is one clean result; a backup with low desk-reject risk.
3. **Score each** (WebSearch / WebFetch the journal's recent volumes for the Foundation and Frontier authors and for similar designs, and its author guidelines for limits and policies; never trust memory for caps and policies):

   | Dimension | Scale | Note |
   |---|---|---|
   | Impact | 1–5 | Generalist vs. specialist matters; cite counts are a noisy proxy |
   | Fit | 1–5 | Nothing in this conversation in 5 years = low; where the lit map's papers appeared = high |
   | Method receptivity | 1–5 | Recent papers using this design; formal, experimental, and qualitative mixes |
   | Word-limit fit | 1–5 | Actual length vs. the hard cap, with the appendix policy |
   | Review turnaround | 1–5 | Median to first decision, from posted data when available |
   | Desk-reject risk | 1–5 (5 = low) | Editor's stated criteria; letters vs. articles |
   | Replication and OA policy | note | Verification before publication (AJPS), Dataverse deposit, pre-acceptance OA, restricted-data rules; each adds time to plan for |

4. **Tier the top 3:** **Reach** (highest impact with fit ≥ 3), **Realistic** (highest fit × low desk-reject risk × decent impact), **Backup** (high acceptance probability; preserves time-to-publication).
5. **Write** the comparison table to `.mstack/journal-fit-<YYYY-MM-DD>.md` and set `target_journals` in `.mstack/config.yaml` to the three tiers.
6. **Recommend** the submission journal in two sentences, tied to the abstract framing chosen in `/mstack:abstract-shotgun` and to the replication timeline the journal's policy implies.

## Outputs

- `.mstack/journal-fit-<date>.md`; `.mstack/config.yaml` (`target_journals`).
- Summary block: three tiers with one-line justifications, the recommended journal, and the policy step (replication verification, deposit) to start now.

## Anti-patterns

- **One-tier strategy.** Always reach, realistic, backup; research is too long to bet on one journal.
- **Impact-only ranking.** 5/5 impact with 1/5 fit has zero expected value.
- **Ignoring desk-reject risk.** The user must know it going in.
- **Remembered limits and policies.** Fetch them.

## Next

`/mstack:submission-pack`, then `/mstack:cover-letter` for the chosen journal. `/mstack:referee-mock editor` beforehand stress-tests fit.
