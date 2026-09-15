---
name: r-and-r
description: Builds the response-to-reviewers document — every comment quoted verbatim, answered, and mapped to a located manuscript change, plus editor summary and change log. Use when the user has a revise-and-resubmit decision letter or referee reports to answer, or pastes reviewer comments and asks how to respond.
argument-hint: "[r1|r2|r3]"
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash(date *)
  - Bash(git log *)
  - Grep
---

# /mstack:r-and-r

**Stage:** submit (R&R) · **Voice:** the author addressing editor and reviewers

Decision letter in hand, revision done: write the response that gets the paper across the line, not the one that argues with the reviewer.

`$ARGUMENTS` is the round (`r1` default; `r2`, `r3` for later rounds).

## Procedure

1. **Decision letter.** Read `submission/response-to-reviewers/r<N>-decision.md`; if absent or empty, ask the user to paste the editor's letter and the reviewer reports there and stop until they do.
2. **Manuscript and diff.** Read `paper/main.tex` + `paper/sections/`, and `output/tables/` and `output/figures/` (they may have changed). If git is in use, `git log --since="<submission date>" --stat -- paper/` shows what actually changed.
3. **Parse the comments** into a structured list: editor comments (top-level, then specific); each reviewer's comments numbered as the reviewer numbered them; tag each `Major`, `Minor`, or `Editor`, and note where reviewers contradict each other (resolve those by naming the conflict and following the editor's steer, or asking the editor). Triage: comments that change the headline get new analysis; comments about clarity get rewritten text; comments that misread the paper get the misreading corrected in the manuscript, not only in the response, since the next reader will misread it the same way.
4. **Respond to each comment** in three parts, in this order:
   1. **Quote the comment verbatim** (blockquote), so response and comment stay aligned.
   2. **Respond.** Concede where conceding is right, defend where defending is right, never concede the contribution to placate. Keep "we appreciate / we agree" sparse; the structure is enough.
   3. **Point to the change** — section, page or paragraph, and the new text quoted. If nothing changed, say so and why.
5. **Editor opener:** thank editor and reviewers once, briefly; the three most consequential changes; the structure of the document.
6. **Change log** table at the end: `Comment ID | Change made | Location`.
7. **Cross-checks:** every comment has a response; every claimed change cites a location; new analyses run through `/mstack:results-audit` and appear in the appendix with a pointer, not as loose numbers in the response; the contribution sentence in abstract / intro has not weakened relative to the prior version; no new claims beyond the letter (don't pick fights); the tone is the same for the reviewer you agree with and the one you do not.
8. **Save** `submission/response-to-reviewers/r<N>-response.md`; append `- "<date>: r<N> <decision> — response drafted"` to `decisions:` in `.mstack/config.yaml` and set `paper.status: "r-and-r"`.

## Outputs

- `submission/response-to-reviewers/r<N>-decision.md` (created if missing) and `r<N>-response.md`.
- Summary block: response count, most consequential changes, open items (comments without a manuscript change).

## Anti-patterns

- **Conceding the contribution to placate R2.** Eroding the headline is worse than defending it well.
- **Combat.** Reviewers respond to deferential confidence.
- **Hand-waving.** "Addressed throughout the manuscript" is not a response; cite the page.
- **Rewriting comments.** Verbatim; the reviewer's words are the contract.

## Next

`/mstack:results-audit` if any results changed; `/mstack:referee-mock editor` to stress-test the response; `/mstack:coauthor-review` on the revised manuscript.
