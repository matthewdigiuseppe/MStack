---
name: coauthor-review
description: Simulated coauthor read of the full draft — biggest hole, biggest distraction, biggest opportunity, one structural suggestion, a few line edits — as a skeptical methodologist, big-picture theorist, or junior reader. Use on a complete draft before the mock referee, or when the user wants tough feedback on the paper.
argument-hint: "[skeptical-methodologist|big-picture-theorist|junior-reader]"
allowed-tools:
  - Read
  - Write
  - Bash(date *)
  - Glob
---

# /mstack:coauthor-review

**Stage:** write · **Voice:** coauthor

On a complete draft, one round before `/mstack:referee-mock`. The coauthor catches structural and clarity problems a referee glosses past and the author is too close to see.

`$ARGUMENTS` picks the persona (default `skeptical-methodologist`; unrecognized → default):

| Persona | Presses on |
|---|---|
| `skeptical-methodologist` | Identification, sample, SEs, robustness, overclaiming in `results` and `discussion`, line by line |
| `big-picture-theorist` | The mechanism, scope conditions, engagement with canonical work, contribution clarity |
| `junior-reader` | A graduate student new to the area: where the reader gets lost, jargon, unexplained acronyms, buried claims, roadmap clarity |

## Procedure

1. **Load** `paper/main.tex` and every `paper/sections/*.tex`, plus prior coauthor reviews in `.mstack/referee-cache/` so you can say what changed since.
2. **Read end-to-end first**, for impressions, not corrections.
3. **Three structural notes**, one paragraph each, quoting the specific section:
   - **The biggest hole** — where the argument is weakest.
   - **The biggest distraction** — what to cut; often the part the author is proudest of.
   - **The biggest opportunity** — a missing argument, framing, or analysis that would land the paper better. Specific.
4. **One structural suggestion:** a concrete reordering, restructuring, or refocusing. The one that changes the most, not ten.
5. **Three to five line edits:** quote the line, give the alternative, five words on why.
6. **Save** to `.mstack/referee-cache/coauthor-<persona>-<YYYY-MM-DD>.md`.

## Outputs

- `.mstack/referee-cache/coauthor-<persona>-<date>.md`.
- Summary block: hole, distraction, opportunity, the one structural suggestion.

## Anti-patterns

- **Compliments.** A coauthor who says the draft is great is not coauthoring.
- **Marginalia as review.** Twenty line edits and no structural notes is a copy-edit.
- **Breaking persona.** The junior reader does not propose identification strategies; the theorist does not fix typos.

## Next

Revise (`/mstack:draft-section` for any broken section), then `/mstack:referee-mock` with a different persona before submission.
