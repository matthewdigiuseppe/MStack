---
name: draft-section
description: Drafts one manuscript section (intro, theory, data, methods, results, discussion, abstract) to paper/sections/ in the configured writing voice, numbers checked against output/, no invented citations. Use when the user asks to write or revise any part of the paper.
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

1. **Load** `.mstack/config.yaml` (title, target journals, status) and `.mstack/learnings.jsonl` (conventions, variable names, framing). List the citable keys instead of reading the whole bibliography: `grep -o '^@[A-Za-z]*{[^,]*' paper/refs.bib`. Read in full only the files the section depends on, and skim the other sections by heading (`grep -n '^\\section' paper/sections/*.tex`) so cross-references stay consistent without loading the manuscript every time:

   | Section | Reads in full |
   |---|---|
   | `intro` | `theory`, `results` (the contribution and headline it must promise); `.mstack/lit-map.md` |
   | `theory` | `intro`; `.mstack/theory.md`, `.mstack/hypotheses.md` |
   | `data` | `methods`; `data/codebook.md`, `data/raw/PROVENANCE.md` |
   | `methods` | `data`, `theory`; `.mstack/identification-review-*.md`, `code/02-analyze.R` |
   | `results` | `methods`; `code/02-analyze.R`, `output/tables/*`, `output/figures/*` |
   | `discussion` | `results`, `intro`; `.mstack/identification-review-*.md`, `.mstack/robustness-*.md` |
   | `abstract` | `intro`, `results`, `discussion` |

   Every number in `methods` / `results` prose must match the tables on disk.
2. **Voice.** If `voice.writing_style` names a skill, invoke it for tone, rhythm, and vocabulary. If unset, write clean generic academic prose (short sentences, active verbs, no hedge-stuffing, no thesaurus reaches) and tell the user once that they can set a style skill in `.mstack/config.yaml`.
3. **Draft to the section's bar:**

   | Section | Bar |
   |---|---|
   | `intro` | Hook, puzzle, contribution, roadmap. The puzzle survives a "so what?" attack in two sentences. |
   | `theory` | Mechanism in one sentence; DAG or prose analog; scope conditions; hypotheses numbered (H1, H2…). |
   | `data` | Sources, vintage, unit of analysis, sample restrictions, missingness; every claim cites the codebook. |
   | `methods` | Specification in equation form; identifying assumption stated; standard errors justified. |
   | `results` | One claim per table / figure; numbers match `output/`; coefficient and CI, never "highly significant". |
   | `discussion` | What the result is and is not; scope, threats, alternative explanations addressed; implications proportional to evidence. |
   | `abstract` | One paragraph: question, design, finding, contribution; ≤ 250 words unless the journal demands less. |

4. **Citations.** Only keys already in `paper/refs.bib`. For a missing one, insert `\cite{TODO-author-year-keyword}` and append `% TODO: add ref — <one-line description>`. Never fabricate author-year-title combinations.
5. **Write** to `paper/sections/<name>.tex` (`.qmd` if `.mstack/config.yaml` says `format: quarto`). Overwrite only if the file is empty or a placeholder comment; otherwise show the candidate and ask whether to overwrite, append, or save as `paper/sections/<name>.candidate.tex`. On the first substantive section, set `paper.status: "writing"`.

## Outputs

- `paper/sections/<section>.tex`.
- Optional `.mstack/draft-log.md` — one line per draft: date, section, word count, open TODOs.

## Anti-patterns

- **Fabricated citations.** TODO markers, never inventions.
- **Drafting `results` before analysis is stable.** Missing tables or figures → stop and run `/mstack:analyze`.
- **Generic voice over a configured style.** Defer to the style skill; do not paper over it with hedge phrases.
- **Filling space.** Short and sharp beats long and hedged.

## Next

Before `intro`, `/mstack:lit-map` output should exist; before `methods`, `/mstack:identification-review`. After `abstract`, `/mstack:abstract-shotgun`. After all sections, `/mstack:coauthor-review` then `/mstack:referee-mock`.
