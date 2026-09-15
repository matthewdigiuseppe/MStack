---
name: draft-section
description: Drafts one manuscript section (intro, theory, data, methods, results, discussion, abstract) to paper/sections/ in the user's configured writing voice, to the substantive bar each section owes the reader — contribution with a number, estimand and identifying assumption stated, results tied to tables with intervals and magnitudes, causal language matched to the design, nulls read against the smallest effect of interest — with numbers checked against output/ and no invented citations. Use when the user asks to write or revise any part of the paper.
argument-hint: "intro|theory|data|methods|results|discussion|abstract"
allowed-tools:
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - Bash
---

# /mstack:draft-section

**Stage:** write · **Voice:** writer, anchored to `voice.writing_style` in `.mstack/config.yaml`

Draft once results are stable (`output/tables/` and `output/figures/` no longer changing) and a target journal is set; prose written before results lock gets rewritten.

`$ARGUMENTS` is the section: `intro`, `theory`, `data`, `methods`, `results`, `discussion`, or `abstract`. If missing or unrecognized, list these and stop.

## Procedure

1. **Load** `.mstack/config.yaml` (title, target journals, status), `.mstack/learnings.jsonl` (conventions, variable names, framing), every existing section in `paper/sections/` (the manuscript is the context; consistency across sections is a referee's first check), the citable keys of `paper/refs.bib` (`grep -o '^@[A-Za-z]*{[^,]*' paper/refs.bib`), and the upstream memos the section depends on:

   | Section | Upstream memos and artifacts |
   |---|---|
   | `intro` | `.mstack/research-question.md`, `.mstack/lit-map.md`, `.mstack/hypotheses.md` (estimand), the primary table and figure |
   | `theory` | `.mstack/theory.md` (mechanism, DAG, rivals, scope), `.mstack/hypotheses.md` |
   | `data` | `data/codebook.md`, `data/raw/PROVENANCE.md`, `data/clean/clean-log.md`, the variation figure |
   | `methods` | `.mstack/identification-review-*.md`, `prereg/osf-prereg.md`, `code/02-analyze.R` |
   | `results` | `code/02-analyze.R`, `output/tables/*`, `output/figures/*`, `output/analyze-log.md`, `.mstack/robustness-*.md` |
   | `discussion` | `.mstack/theory.md` (scope, rivals), `.mstack/identification-review-*.md`, `.mstack/robustness-*.md` |
   | `abstract` | `intro`, `results`, `discussion` |

   Every number in `methods` / `results` prose must match the tables on disk.
2. **Read** `${CLAUDE_PLUGIN_ROOT}/references/writing-conventions.md` for what the section owes the reader and the referee complaints it must pre-empt.
3. **Voice.** If `voice.writing_style` names a skill, invoke it for tone, rhythm, and vocabulary. If unset, write clean generic academic prose (short sentences, active verbs, no hedge-stuffing, no thesaurus reaches) and tell the user once that they can set a style skill in `.mstack/config.yaml`.
4. **Draft to the section's bar:**

   | Section | Bar |
   |---|---|
   | `intro` | Opens with the question and its stake; a contribution paragraph with what we do, what we find (a number in substantive units), and what changes if believed; the design and estimand in one sentence; positioned against the two or three closest papers; roadmap in one sentence or none. The puzzle survives a "so what?" attack in two sentences. |
   | `theory` | Mechanism in one sentence and its steps; assumptions; observable implications that separate it from the named rivals; scope conditions as where it fails; hypotheses numbered with direction and estimand. |
   | `data` | Unit and coverage; sources with vintages; each key variable's operationalization with a validity argument; the variation the design uses, shown; missingness and restrictions with counts; every claim cites the codebook. |
   | `methods` | Estimand, then the identifying assumption in one sentence, then the equation with every symbol defined, fixed effects, and clustering; why this comparison isolates the effect; the falsification tests and sensitivity analysis; preregistration status and deviations; the estimator cited. |
   | `results` | Primary estimate first, then falsification tests, mechanism, heterogeneity, and a one-paragraph robustness summary with the sensitivity sentence; one claim per table or figure; point estimate, interval, and magnitude against a benchmark; causal verbs only under a design that licenses them; nulls read against the SESOI, never as "no effect"; no "highly significant". |
   | `discussion` | The contribution restated with its evidence; what the result is not (the estimand's limits); the most plausible rival explanation and why the evidence weighs against it; specific limitations; implications proportional to evidence; one concrete next study. |
   | `abstract` | Question, design with estimand, data, the finding with a number, contribution; within the journal's cap; no citations, no hedging stack. |

5. **Citations.** Only keys already in `paper/refs.bib`. For a missing one, insert `\cite{TODO-author-year-keyword}` and append `% TODO: add ref — <one-line description>`. Never fabricate author-year-title combinations. Cite the methods used (estimators, sensitivity tools) where the reference file names them.
6. **Write** to `paper/sections/<name>.tex` (`.qmd` if `.mstack/config.yaml` says `format: quarto`). Overwrite only if the file is empty or a placeholder comment; otherwise show the candidate and ask whether to overwrite, append, or save as `paper/sections/<name>.candidate.tex`. On the first substantive section, set `paper.status: "writing"`.
7. **Self-check before saving:** every number in the section appears in a table, figure, or the analyze log; every table and figure referenced exists; causal language matches `design.type`; the estimand named here is the one in `hypotheses.md`; no citation key is invented.

## Outputs

- `paper/sections/<section>.tex`.
- Optional `.mstack/draft-log.md` — one line per draft: date, section, word count, open TODOs.

## Anti-patterns

- **Fabricated citations.** TODO markers, never inventions.
- **Drafting `results` before analysis is stable.** Missing tables or figures → stop and run `/mstack:analyze`.
- **Generic voice over a configured style.** Defer to the style skill; do not paper over it with hedge phrases.
- **A literature review where the theory should be.**
- **Nulls as zeros and associations as effects.**
- **Filling space.** Short and sharp beats long and hedged.

## Next

Before `intro`, `/mstack:lit-map` output should exist; before `methods`, `/mstack:identification-review`. After `abstract`, `/mstack:abstract-shotgun`. After all sections, `/mstack:coauthor-review` then `/mstack:referee-mock`.
