---
name: cover-letter
description: Drafts a cover letter to a chosen journal and editor. Three short paragraphs — fit, contribution, declarations. Use after /journal-fit. Writes to submission/cover-letter.md.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
---

# /mstack:cover-letter

**Stage:** submit
**Voice:** editor (calibrated as the author addressing the editor)

## When to invoke

After `/journal-fit` settles a target journal. The cover letter is read in 30 seconds; precision and specificity matter more than warmth.

## Procedure

1. **Load.** `.mstack/config.yaml` (target journal — top tier), abstract from `paper/sections/abstract.tex`, contribution sentence from `.mstack/research-question.md`.

2. **Identify the editor.** Ask the user for the current editor name and salutation if not in `.mstack/config.yaml`. Don't guess from training data — editors change.

3. **Draft three paragraphs, ≤ 400 words total:**

   ### ¶1: Fit
   What the paper does, in one sentence, and why it fits *this* journal. Reference one or two recent papers from the journal it's in conversation with — concrete, not "this builds on the journal's strong tradition in X."

   ### ¶2: Contribution
   What the paper adds. Use the contribution sentence from `/research-question`. State the headline finding and the design that delivers it. Resist hedge language.

   ### ¶3: Declarations
   - Preregistration status + URL (from `.mstack/config.yaml`).
   - Data and code availability (link or commitment).
   - Not under review elsewhere.
   - Conflicts of interest.
   - IRB approval if applicable.
   - Word count.
   - Acknowledgement of past presentations / earlier versions if any.

4. **Sign-off.** Author name(s) and affiliation(s). One line.

5. **Save** to `submission/cover-letter.md`. Format as Markdown — convert to whatever the journal accepts at submission time.

6. **Cross-check** before declaring done:
   - Editor name correct and current.
   - Journal name spelled correctly throughout.
   - Word count within journal limit.
   - Declarations cover everything the journal's submission portal will ask.

## Outputs

- `submission/cover-letter.md`.
- Summary block: word count, editor addressed, declarations covered.

## Anti-patterns to refuse

- **Sycophancy.** Editors do not need to be told their journal is excellent.
- **Generic.** "This paper would be of interest to your readership" with no specific recent paper cited is generic and noticeable.
- **Five paragraphs.** Three. Tight.
- **Repeating the abstract.** The cover letter does what the abstract can't: situates the paper for *this* editor, *this* journal.

## When to call other skills

- Before: `/journal-fit`.
- After: submit. On decision: `/r-and-r` if R&R; `/journal-fit` again if rejected.
