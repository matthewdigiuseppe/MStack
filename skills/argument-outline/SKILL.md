---
name: argument-outline
description: Builds the paper's argument before any prose — the governing claim from the spine, the three or four supporting claims a skeptical reader must accept, the table, figure, or cited result behind each, and the section and paragraph plan that follows — and sorts every other table, analysis, and passage into appendix or cut. Use after results are stable and before drafting, when a draft wanders or a reader misses the point, or when the user asks to outline, storyboard, restructure, or tighten the paper.
allowed-tools:
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - Bash(date *)
---

# /mstack:argument-outline

**Stage:** write (before prose) · **Voice:** structural editor

After `/mstack:claim-sharpen` has restated the spine against the results, before `/mstack:draft-section`. A paper drafted section by section fills each section with what that section usually contains; a paper drafted from an outline of claims contains what the argument needs. On an existing draft the same procedure runs in reverse and finds the passages that serve nothing.

## Procedure

1. **Load** `.mstack/spine.md` (if its claim predates the audited results, stop and run `/mstack:claim-sharpen`), `.mstack/theory.md` (mechanism, rivals), `.mstack/hypotheses.md`, `output/analyze-log.md`, the file lists of `output/tables/` and `output/figures/`, `.mstack/robustness-*.md`, `.mstack/identification-review-*.md` (falsification tests), `.mstack/config.yaml` (the target journal's word cap), and any drafted `paper/sections/*`. Read the ladder and the objections table in `${CLAUDE_PLUGIN_ROOT}/references/contribution.md`.
2. **Structure rules.** If `voice.outline_style` in `.mstack/config.yaml` names an installed skill (a pyramid-principle skill, for instance), invoke it for how claims are grouped and ordered. Otherwise: the governing claim on top; under it the claims that are each necessary and together sufficient for a skeptical reader to accept it; every line a sentence that could be false.
3. **Governing claim:** the spine's `Claim`, verbatim.
4. **Supporting claims, three or four,** in the order the reader in the spine's second line would ask for them. The usual set: the pattern exists and is this large; it is the effect of X and not the strongest rival; it runs through the mechanism; it matters at the scale claimed. For each:

   | Field | Content |
   |---|---|
   | Claim | One sentence that could be false |
   | Carried by | The one table, figure, or cited result, by file name in `output/` |
   | Pre-empts | The objection it answers, in the reader's words |
   | Lives in | The section and paragraph |

   A supporting claim with nothing on disk behind it is a hole: mark it `MISSING` with what would fill it. The first supporting claim rests on the item in the spine's `Carried by`.
5. **Inventory.** Assign every table and figure in `output/`, every model in the analyze log, and every drafted subsection to a supporting claim, to `appendix` (supports a claim but the main text does not need it), or to `cut` (serves no claim). With a draft on disk, also take each paragraph's topic sentence and assign it the same way. List what was cut, however much it cost to produce.
6. **Section plan.** For each section, its job in the argument in one sentence, then its paragraphs as topic sentences, each a claim. Read alone, the topic sentences are the argument. Give each section a word budget that sums to the journal's cap.
7. **Check before saving:** the governing and supporting claims, read alone, would move the reader named in the spine; every supporting claim has evidence or is marked `MISSING`; no main-text table or figure lacks a claim; no supporting claim leans on an analysis the audit failed or on a specification labeled exploratory without saying so. If the outline shows that a line of the spine is wrong (the table that carries the claim, what it does not cover), edit that line and its log first.
8. **Save** `.mstack/outline.md`: governing claim, supporting-claims table, section plan, the appendix list, the cut list, and the holes.

## Outputs

- `.mstack/outline.md`.
- Summary block: the governing claim, the supporting claims with their evidence, the holes, and what goes to the appendix or is cut.

## Anti-patterns

- **An outline of sections.** "Introduction, Theory, Data" is a table of contents; the outline is of claims.
- **Topics for claims.** "Robustness" is a topic; "the estimate holds across 94% of defensible specifications" is a claim.
- **A fifth supporting claim.** It is another paper or an appendix.
- **Keeping an orphan because it was expensive.**
- **Outlining a claim the results have overtaken.**

## Next

`/mstack:draft-section`, which drafts against the outline. On a full draft, `/mstack:coauthor-review` tests whether a cold reader comes away with the governing claim.
