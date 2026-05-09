---
name: referee-mock
description: Generates a mock R1 referee report on the current draft. Wraps the journal-reviewer-style skill. Front-runs the actual reviewer so problems are caught pre-submission. Writes to .mstack/referee-cache/.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Bash(date *)
  - Glob
  - Grep
---

# /mstack:referee-mock

**Stage:** write (pre-submission)
**Voice:** referee (anchored to `journal-reviewer-style`)

## When to invoke

When all sections of the manuscript exist in `paper/sections/` and the draft is "submission-ready." This skill is your last line of defense before reviewers see it.

## Argument

`$ARGUMENTS` (optional) — referee persona. One of:

- `methodologist` (default) — prosecutes identification and inference.
- `theorist` — prosecutes theoretical novelty and engagement with the literature.
- `area-expert` — prosecutes empirical/contextual claims.
- `editor` — prosecutes fit, contribution-per-page, and clarity.

If unrecognized, default to `methodologist`.

## Procedure

1. **Load the manuscript.**
   - Read `paper/main.tex` (or `main.qmd`) and every file under `paper/sections/`.
   - Read `output/tables/` and `output/figures/` to verify claims in the prose.
   - Read `.mstack/config.yaml` to know the target journal — referees calibrate to journal expectations.

2. **Load prior referee snapshots** in `.mstack/referee-cache/`. If the same persona produced a report on an earlier draft, the new report should explicitly note what improved and what didn't.

3. **Invoke the reviewer-style skill.**
   - Use the **journal-reviewer-style** skill for voice, tone, and structural conventions of a referee report in IPE / political science.
   - If `.mstack/config.yaml` overrides `voice.reviewer_style`, honor that.

4. **Write the report** with the persona's bias dialed in:

   | Persona | Where to press hardest |
   |---|---|
   | `methodologist` | Identification, SE clustering, robustness, multiple comparisons, sample restrictions, attrition |
   | `theorist` | Theoretical contribution, mechanism vs. correlation, engagement with canonical 3–5 papers, scope conditions |
   | `area-expert` | Empirical/case knowledge, measurement validity, omitted contextual factors, source reliability |
   | `editor` | Contribution-per-page, fit with target journal, clarity, headline-vs-evidence proportionality, length |

5. **Standard report structure:**
   - **Summary** (1 paragraph): what the paper does and what it claims.
   - **Major comments** (3–6): substantive issues that change the headline if not addressed.
   - **Minor comments** (5–15): clarity, presentation, missing citations, table/figure issues.
   - **Recommendation:** one of `Reject`, `Major revisions`, `Minor revisions`, `Accept`. Be the reviewer you fear, not the reviewer you hope for.

6. **Save to `.mstack/referee-cache/referee-mock-<persona>-<YYYY-MM-DD>.md`.** Include a header with: persona, target journal, draft commit hash (if a git repo) or word count, date.

## Outputs

- `.mstack/referee-cache/referee-mock-<persona>-<date>.md`
- A summary block printed to the user with: top 3 major comments, the recommendation, and a suggestion to run the persona you didn't run.

## Anti-patterns to refuse

- **Sycophancy.** "Strong contribution" with no caveats fails the user. If you can't think of a major comment, you're not reading hard enough.
- **Generic comments.** "Could use more theory" is useless. Cite a section, line, or table.
- **Speaking outside the persona.** A `methodologist` doesn't critique prose style; an `editor` doesn't propose new identification strategies.

## When to call other skills

- After report: if recommendation is `Major revisions` or worse, suggest `/results-audit` and `/identification-review` before the user revises.
- Once the user has revised: suggest re-running `/referee-mock` with a different persona to triangulate.
