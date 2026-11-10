---
name: coauthor-review
description: Simulated coauthor read of the full draft — first whether a cold reader comes away with the paper's claim, then the biggest hole in the argument for it, the biggest distraction from it, the biggest opportunity to strengthen it, and one structural suggestion — as a skeptical methodologist, big-picture theorist, or junior reader. Use on a complete draft before the mock referee, or when the user wants tough feedback on the paper.
argument-hint: "[skeptical-methodologist|big-picture-theorist|junior-reader] [lines]"
allowed-tools:
  - Read
  - Write
  - Agent
  - Bash(date *)
  - Glob
---

# /mstack:coauthor-review

**Stage:** write · **Voice:** coauthor

On a complete draft, one round before `/mstack:referee-mock`. The coauthor catches what a referee glosses past and the author is too close to see: whether the paper says its claim, and what in the draft works for or against it.

`$ARGUMENTS` picks the persona (default `skeptical-methodologist`; unrecognized → default) and, with `lines`, adds line edits:

| Persona | Presses on |
|---|---|
| `skeptical-methodologist` | Whether the evidence licenses the claim as worded: identification, the effective sample, uncertainty, overclaiming in `results` and `discussion` |
| `big-picture-theorist` | Whether the claim follows from the mechanism and is worth making: scope, engagement with canonical work, what it is a case of |
| `junior-reader` | A graduate student new to the area: where the claim gets lost, jargon, unexplained acronyms, buried findings, roadmap clarity |

## Procedure

1. **Comprehension test, before any memo is opened.** Spawn a fresh subagent (the Agent tool, general-purpose, not a fork) that is given only `paper/main.tex` (or `main.qmd`) and `paper/sections/`, is told to open nothing under `.mstack/`, and returns exactly: the paper's main claim in one sentence; the evidence it rests on in one sentence; why it matters and to whom in one sentence; the sentence in the draft that states the claim, quoted with its location; and where in the draft the claim first became clear. With no subagent tool, do this read yourself now and write the answers down before going on. Then read `.mstack/spine.md` and compare: **match** (same claim, evidence, and stake, clear by the end of the introduction), **partial** (the claim matches but the evidence or stake does not, or the claim surfaces only after the introduction), **mismatch** (a different claim, or none could be stated). A partial or mismatch is the first finding of the review, ahead of everything below: either the draft does not say what the author means, or the spine no longer describes the paper.
2. **Load** `.mstack/spine.md`, `.mstack/outline.md` if present (the supporting claims, the cut list), `paper/main.tex` and every `paper/sections/*.tex`, plus prior coauthor reviews in `.mstack/referee-cache/` so you can say what changed since.
3. **Read end-to-end**, for the argument, not for corrections. Then read the referee complaints table in `${CLAUDE_PLUGIN_ROOT}/references/writing-conventions.md`; the big-picture theorist also reads `${CLAUDE_PLUGIN_ROOT}/references/contribution.md`, the skeptical methodologist the design section of `${CLAUDE_PLUGIN_ROOT}/references/identification-threats.md`.
4. **Three structural notes**, one paragraph each, quoting the specific section and saying what the point does to the claim:
   - **The biggest hole** — the supporting claim the reader is least likely to accept, and why. If the hole breaks the claim rather than narrowing it, say so in the first sentence.
   - **The biggest distraction** — the material that serves no supporting claim and should be cut or moved to the appendix; often the part the author is proudest of.
   - **The biggest opportunity** — the framing, comparison, or analysis that would let the paper claim more, or be believed sooner. Specific.
5. **One structural suggestion:** a concrete reordering, restructuring, or refocusing. The one that changes the most, not ten.
6. **Line edits only with `lines`,** and only on the sentences that state the claim (abstract, the contribution paragraph, the first sentence of `results`, the opening of `discussion`): at most three, each with the line quoted, the alternative, and five words on why.
7. **Save** to `.mstack/referee-cache/coauthor-<persona>-<YYYY-MM-DD>.md`, with a header line `Comprehension: match | partial | mismatch` followed by the cold reader's three sentences beside the spine's.

## Outputs

- `.mstack/referee-cache/coauthor-<persona>-<date>.md`.
- Summary block: the comprehension result, hole, distraction, opportunity, the one structural suggestion.

## Anti-patterns

- **Compliments.** A coauthor who says the draft is great is not coauthoring.
- **Marginalia as review.** Notes on points that leave the claim untouched are a copy-edit, however many there are.
- **Loading the spine before the cold read.** Once the claim has been read, the draft will seem to say it.
- **Breaking persona.** The junior reader does not propose identification strategies; the theorist does not fix typos.

## Next

Partial or mismatch → `/mstack:argument-outline`, then redraft the abstract and introduction. An opportunity worth taking → `/mstack:claim-sharpen`. Then revise (`/mstack:draft-section` for any broken section) and run `/mstack:referee-mock` for the target journal before submission.
