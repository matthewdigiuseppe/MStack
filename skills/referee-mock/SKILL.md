---
name: referee-mock
description: Mock R1 referee report (methodologist, theorist, area-expert, or editor persona) calibrated to the target journal — summary, major and minor comments, honest recommendation. Use when a draft is near submission-ready or the user asks how reviewers will react.
argument-hint: "[methodologist|theorist|area-expert|editor]"
allowed-tools:
  - Read
  - Write
  - Bash(date *)
  - Bash(git rev-parse *)
  - Glob
  - Grep
---

# /mstack:referee-mock

**Stage:** write (pre-submission) · **Voice:** referee, anchored to `voice.reviewer_style` in `.mstack/config.yaml`

When every section exists and the draft is "submission-ready": the last line of defense before real reviewers.

`$ARGUMENTS` picks the persona (default `methodologist`; unrecognized → default):

| Persona | Presses hardest on |
|---|---|
| `methodologist` | Identification, SE clustering, robustness, multiple comparisons, sample restrictions, attrition |
| `theorist` | Theoretical contribution, mechanism vs. correlation, engagement with the canonical 3–5 papers, scope conditions |
| `area-expert` | Empirical / case knowledge, measurement validity, omitted contextual factors, source reliability |
| `editor` | Contribution per page, fit with the target journal, clarity, headline-vs-evidence proportionality, length |

## Procedure

1. **Load** `paper/main.tex` (or `main.qmd`) and every file under `paper/sections/`; `output/tables/` and `output/figures/` to verify claims in the prose; `.mstack/config.yaml` for the target journal, which sets the bar.
2. **Prior reports** in `.mstack/referee-cache/`: if the same persona reviewed an earlier draft, say explicitly what improved and what did not.
3. **Reviewer style.** If `voice.reviewer_style` names an installed skill, use it for voice, tone, and structure; otherwise `${CLAUDE_PLUGIN_ROOT}/references/referee-report-conventions.md`.
   **Persona ammunition.** `methodologist`: read the design section of `${CLAUDE_PLUGIN_ROOT}/references/identification-threats.md` and raise every threat the paper does not address, plus the sensitivity analysis it does not report. `theorist`: the rival-mechanisms table in `.mstack/theory.md`, and whether the paper tests any of them. `editor`: the referee complaints table in `${CLAUDE_PLUGIN_ROOT}/references/writing-conventions.md`. `area-expert`: the data-source pitfalls in `${CLAUDE_PLUGIN_ROOT}/references/polisci-data-sources.md` for the sources the paper uses.
4. **Write the report** in the standard structure:
   - **Summary** (one paragraph) — what the paper does and what it claims.
   - **Major comments** (3–6) — substantive issues that change the headline if unaddressed.
   - **Minor comments** (5–15) — clarity, presentation, missing citations, table / figure issues.
   - **Recommendation** — `Reject`, `Major revisions`, `Minor revisions`, or `Accept`. Be the reviewer the author fears, not the one they hope for.
5. **Save** to `.mstack/referee-cache/referee-mock-<persona>-<YYYY-MM-DD>.md` with a header: persona, target journal, draft commit hash (`git rev-parse --short HEAD` if a git repo) or word count, date.

## Outputs

- `.mstack/referee-cache/referee-mock-<persona>-<date>.md`.
- Summary block: top 3 major comments, the recommendation, and the persona to run next.

## Anti-patterns

- **Sycophancy.** No major comment means you did not read hard enough.
- **Generic comments.** "Could use more theory" is useless; cite the section, line, or table.
- **Breaking persona.** The methodologist does not critique prose style; the editor does not propose identification strategies.

## Next

`Major revisions` or worse → `/mstack:results-audit` and `/mstack:identification-review` before revising. After revision, re-run with a different persona to triangulate.
