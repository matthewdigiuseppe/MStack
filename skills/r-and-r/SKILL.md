---
name: r-and-r
description: Drafts a response-to-reviewers document with a change log mapping every reviewer comment to a manuscript change. Use during revise-and-resubmit. Writes to submission/response-to-reviewers/r<N>-response.md.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash(date *)
  - Grep
---

# /mstack:r-and-r

**Stage:** submit (R&R)
**Voice:** editor (calibrated as the author addressing the editor and reviewers)

## When to invoke

You have a decision letter from the journal. The paper has been revised. Now you need to write the response that gets it across the line — not the response that argues with the reviewer.

## Argument

`$ARGUMENTS` (optional) — round number. Default `r1`. Use `r2`, `r3` for subsequent rounds.

## Procedure

1. **Load the decision letter.**
   - Ask the user to paste the editor's letter and the reviewer reports into `submission/response-to-reviewers/r<N>-decision.md` if not already there.
   - Read that file. If the file is empty, stop and ask the user for the letter.

2. **Load the manuscript and the diff.**
   - Read current `paper/main.tex` + `paper/sections/`.
   - If git is in use, run `git log --since="<date of submission>" --stat -- paper/` to know what actually changed.
   - Read `output/tables/` and `output/figures/` — these may have changed.

3. **Parse the comments.** Build a structured list:
   - Editor comments (top-level, then specific).
   - For each reviewer: comments numbered as the reviewer numbered them.
   - Tag each comment as `Major`, `Minor`, or `Editor`.

4. **For each comment, draft a response.** Each response has three parts, in order:

   1. **Quote the comment** verbatim (in italics or a blockquote). This forces alignment between what the reviewer said and what you address.
   2. **Respond.** Concede where conceding is right; defend where defending is right; do *not* concede the contribution to placate. Use "we appreciate / we agree / we have addressed this by …" sparingly — the structure is enough; you don't need to thank every comment.
   3. **Point to the change.** Cite the section, page (or paragraph), and quote the relevant new text. If no change was made, say so explicitly and explain why.

5. **Editor opener.** A short cover paragraph at the top:
   - Thank the editor and reviewers (briefly, once).
   - Summarize the most consequential changes (3 bullets).
   - Note the structure of the response document.

6. **Change log.** A table at the bottom: `Comment ID | Change made | Location`. Lets the editor scan.

7. **Cross-checks before finalizing.**
   - Every reviewer comment has a response.
   - Every response that claims a change cites a specific location.
   - The contribution sentence in the abstract / intro has not weakened relative to the prior version.
   - No new claims that weren't in the decision letter (don't pick fights).

8. **Save.**
   - `submission/response-to-reviewers/r<N>-response.md` — the response document.
   - Append a row to `.mstack/decisions.log` (or create it): `<date> | r<N> | <decision> | response drafted`.

## Outputs

- `submission/response-to-reviewers/r<N>-decision.md` — the original letter (created if missing).
- `submission/response-to-reviewers/r<N>-response.md` — the drafted response.
- A summary block to the user: count of responses, the most consequential changes, and remaining open items (any reviewer comment without a corresponding manuscript change).

## Anti-patterns to refuse

- **Conceding the contribution to placate R2.** A response that erodes the headline is a worse response than one that defends it well.
- **Argumentative tone.** Reviewers respond to deferential confidence, not to combat.
- **Hand-waving.** "We have addressed this throughout the manuscript" is not a response. Cite the page.
- **Rewriting comments.** Quote them verbatim. The reviewer's words are the contract.

## When to call other skills

- Before: `/results-audit` if any results changed during revision; `/referee-mock editor` to stress-test the response.
- After: spot-check by running `/coauthor-review` on the revised manuscript.
