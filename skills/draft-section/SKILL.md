---
name: draft-section
description: Drafts a paper section (intro, theory, data, methods, results, discussion, abstract) in voice. Wraps the digiuseppe-writing-style skill. Section name passed as argument. Writes to paper/sections/<name>.tex. Never fabricates citations.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - Bash
---

# /mstack:draft-section

**Stage:** write
**Voice:** writer (anchored to `digiuseppe-writing-style`)

## When to invoke

After analysis is stable (results in `output/tables/` and `output/figures/` are not changing) and the paper has a target journal in `.mstack/config.yaml`. Drafting before results lock in produces prose that has to be rewritten.

## Argument

`$ARGUMENTS` is the section name. One of: `intro`, `theory`, `data`, `methods`, `results`, `discussion`, `abstract`.

If not supplied or unrecognized, list the recognized names and stop.

## Procedure

1. **Load context.**
   - Read `.mstack/config.yaml` for title, target journals, status.
   - Read `.mstack/learnings.jsonl` for paper-specific conventions (variable names, design choices, framing).
   - Read `paper/refs.bib` to know what citations are available — never invent BibTeX entries.
   - Read sibling sections in `paper/sections/` so voice and references stay consistent.
   - For methods/results: read `code/02-analyze.R`, `output/tables/*`, `output/figures/*`. The numbers in your prose must match the tables on disk.

2. **Invoke the writing-style skill.**
   - Use the **digiuseppe-writing-style** skill for tone, sentence rhythm, and vocabulary.
   - If `.mstack/config.yaml` overrides `voice.writing_style`, honor that instead.

3. **Draft the section** with the section-specific bar:

   | Section | Quality bar |
   |---|---|
   | `intro` | Hook, puzzle, contribution, roadmap. The puzzle must survive a "so what?" attack in two sentences. |
   | `theory` | Mechanism in one sentence. DAG or analog in prose. Scope conditions stated. Hypotheses numbered (H1, H2…). |
   | `data` | Sources, vintage, unit of analysis, sample restrictions, missingness. Every claim cites the codebook. |
   | `methods` | Specification in equation form. Identifying assumption stated. Standard errors justified. |
   | `results` | One claim per table/figure. Numbers match `output/`. No "highly significant" — give the coefficient and CI. |
   | `discussion` | What the result is and is not. Scope, threats, alternative explanations addressed. Implications proportional to evidence. |
   | `abstract` | One paragraph: question, design, finding, contribution. ≤250 words unless journal demands less. |

4. **Citations.**
   - Cite only entries already in `paper/refs.bib`.
   - When you need a citation that isn't in `refs.bib`, insert `\cite{TODO-author-year-keyword}` and append a `% TODO: add ref — <one-line description>` comment.
   - Never fabricate author-year-title combinations.

5. **Write to disk.**
   - Output goes to `paper/sections/<name>.tex` (or `.qmd` if `.mstack/config.yaml` says `format: quarto`).
   - Overwrite if the file is empty or contains only a placeholder comment. Otherwise: produce a candidate to stdout and ask whether to overwrite, append, or save to `paper/sections/<name>.candidate.tex`.

## Outputs

- `paper/sections/<section>.tex` — drafted section.
- Optional: `.mstack/draft-log.md` — append a one-line entry per draft (date, section, word count, outstanding TODOs).

## Anti-patterns to refuse

- **Fabricating citations.** Mark missing refs as TODOs; never invent.
- **Drafting `results` before `02-analyze.R` has stable output.** If tables/figures are missing, stop and tell the user to run `/analyze` first.
- **Writing in a generic academic voice** when `digiuseppe-writing-style` is loaded. Defer to it; do not paper over it with hedge phrases.
- **Filling space.** A short, sharp section beats a long, hedging one.

## When to call other skills

- **Before drafting `intro`:** if no `/lit-map` output exists in `.mstack/`, suggest running `/lit-map` first.
- **Before drafting `methods`:** if no `/identification-review` output exists, suggest running it first.
- **After drafting `abstract`:** suggest `/abstract-shotgun` to generate variants.
- **After all sections are drafted:** suggest `/coauthor-review` then `/referee-mock`.
