---
name: coauthor-review
description: Simulated coauthor critique on a complete draft. Configurable persona — skeptical methodologist, big-picture theorist, or junior reader. Writes to .mstack/referee-cache/coauthor-<persona>-<date>.md.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Bash(date *)
  - Glob
---

# /mstack:coauthor-review

**Stage:** write
**Voice:** coauthor

## When to invoke

You have a complete draft, ideally one round before `/referee-mock`. The coauthor catches structural and clarity issues that a referee would gloss past or that you'd internalize too deeply to see.

## Argument

`$ARGUMENTS` (optional) — coauthor persona. One of:

- `skeptical-methodologist` (default) — challenges design and inference, line by line.
- `big-picture-theorist` — challenges the framing, contribution, and engagement with theory.
- `junior-reader` — reads as a graduate student new to the area; flags every "wait, what?".

If unrecognized, default to `skeptical-methodologist`.

## Procedure

1. **Load.** `paper/main.tex` and every `paper/sections/*.tex`. Read prior `/coauthor-review` outputs in `.mstack/referee-cache/` so you can reference what changed since.

2. **Read end-to-end.** Resist the urge to summarize. The first read is for impressions, not corrections.

3. **Three structural notes** (always):
   - **The biggest hole.** One paragraph: where the argument is weakest. Quote the specific section.
   - **The biggest distraction.** One paragraph: what to cut. Often a section the user is proudest of.
   - **The biggest opportunity.** One paragraph: a missing argument, framing, or analysis that would land the paper better. Specific.

4. **One structural suggestion.** A concrete reordering, restructuring, or refocusing. Don't propose ten changes; propose one that changes the most.

5. **Three to five line edits.** Quote the line, give the alternative, explain in five words why.

6. **Persona-specific bias:**

   | Persona | Where to press |
   |---|---|
   | `skeptical-methodologist` | Identification, sample, SE, robustness, overclaiming in `results` and `discussion`. |
   | `big-picture-theorist` | Theory section's mechanism, scope conditions, engagement with canonical work, contribution clarity. |
   | `junior-reader` | Where the reader gets lost. Jargon. Unexplained acronyms. Buried claims. Roadmap clarity. |

7. **Save** to `.mstack/referee-cache/coauthor-<persona>-<YYYY-MM-DD>.md`.

## Outputs

- `.mstack/referee-cache/coauthor-<persona>-<date>.md`.
- Summary block: hole + distraction + opportunity + the one structural suggestion.

## Anti-patterns to refuse

- **Compliments.** A coauthor who tells you the draft is great is not coauthoring.
- **Marginalia masquerading as a review.** Twenty line edits and zero structural notes is a copy-edit, not a review.
- **Speaking outside the persona.** A `junior-reader` doesn't propose new identification strategies; a `theorist` doesn't fix typos.

## When to call other skills

- Before: `/draft-section` for any obviously-broken section.
- After: revise, then run `/referee-mock` (different persona) for a final pre-submission read.
