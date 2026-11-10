---
name: claim-sharpen
description: Works on the paper's main idea as a coauthor would, proposing rather than interrogating — the strongest claim the evidence supports, what the finding is a case of, implications not yet drawn, alternative framings by contribution type, the strongest objection to its importance, and the one addition that would raise what the paper can claim — then revises .mstack/spine.md with a dated log entry. Use after the theory is built and again once results are audited, or when the user asks how to make the argument bigger, sharper, or more interesting, what the paper is really about, or how to frame the contribution.
argument-hint: "[pre|post]"
allowed-tools:
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - Bash(date *)
---

# /mstack:claim-sharpen

**Stage:** map, and again after analysis · **Voice:** coauthor

The one skill in which Claude proposes. Elsewhere MStack interrogates, audits, or drafts to a bar; here it does a coauthor's work on the idea itself: says what it thinks the paper is, offers the bigger and the safer versions, argues for one, and leaves the decision to the author.

Two runs. **Pre-results**, after `/mstack:theory-build`, works from the memos and pushes the claim before it is operationalized. **Post-results**, after `/mstack:results-audit` (and `/mstack:robustness` when it has run), works from the tables: the paper found is rarely the paper planned, and the spine has to say what was found before any prose is drafted. `$ARGUMENTS` forces `pre` or `post`; otherwise post when an audited primary table exists.

## Procedure

1. **Load** `.mstack/spine.md`, `.mstack/research-question.md`, `.mstack/lit-map.md` (the gap, the Frontier papers), `.mstack/theory.md` (mechanism, rivals, scope, off-sample predictions), `.mstack/hypotheses.md` (the primary, its SESOI). Post-results add `output/analyze-log.md`, the primary table, `.mstack/results-audit-*.md`, `.mstack/robustness-*.md` (verdict, sensitivity sentence), and `prereg/osf-prereg.md`. Read `${CLAUDE_PLUGIN_ROOT}/references/contribution.md`. If the spine is missing or holds no claim (a paper started before the spine existed), draft it from these memos first and show it: five one-line fields, `**Claim:**`, `**Who must change their mind:**`, `**Carried by:**`, `**Strongest rival:**`, `**Does not cover:**`, then a `## Log` heading with one dated entry per change.
2. **Say what the paper is, in your own words:** two sentences, written from the evidence on disk before rereading the spine's claim. Post-results they carry the estimate, its interval, and how it sits against the SESOI. Then set them beside the spine. Any difference between the two is the first item on the table.
3. **Propose.** One short paragraph each, in this paper's terms, each ending with whether you would take it:
   - **The strongest defensible claim.** Where the current sentence sits on the ladder in the reference (estimate, finding, proposition, implication), the highest rung the design and evidence pay for, and the sentence at that rung. Say plainly whether the current claim is timid or inflated.
   - **What this is a case of.** The general class the finding belongs to, and the one or two literatures outside the subfield where the same logic is live.
   - **Implications not yet drawn.** Two or three things that must also be true if the claim is: at least one testable with the data in hand, at least one that reinterprets a result in a Foundation or Frontier paper.
   - **Alternative framings.** The same evidence led by each contribution type that fits (new fact, effect, mechanism, adjudication, scope condition, reversal, measurement), each with the reader who would have to change their mind and what the paper would add or drop. Name the one you would lead with.
   - **The importance objection.** The strongest "true, but so what?" from the reference's table, as the reader in the spine's second line would put it, and the best answer the paper has, or the comparison that would give it one.
   - **The one addition.** The single analysis, comparison, or case that would most raise what the paper can claim. One, with its cost.
4. **Hold the line between framing and finding** (post-results). Framing, the rung claimed, and the order of the argument may move. The hypotheses as written before the data, the primary specification, and the confirmatory and exploratory labels do not. A claim resting on an analysis outside the preregistration is marked exploratory in the spine and in the paper. A primary estimate that is null against the SESOI, or a fragile robustness verdict, is restated as what was found: a reversal or a conditional claim, never a subgroup rescue.
5. **Decide with the author.** Present the proposals with your recommendation and ask which to take. In an asynchronous context, write the memo with a proposed spine marked as proposed and stop there.
6. **Revise the spine** for what was taken: edit the changed lines, keep the five under 150 words, and append `- <YYYY-MM-DD> · claim-sharpen (pre|post) · <lines changed> · <why>` to its log. Then say what the change makes stale: `.mstack/hypotheses.md` if the claim moved before data; `.mstack/outline.md`, the abstract, and the introduction if it moved after.
7. **Save** `.mstack/claim-sharpen-<YYYY-MM-DD>.md`: your two sentences, the proposals, what was taken, and what was declined with the reason. Declined framings are the next paper's.

## Outputs

- `.mstack/spine.md` — revised lines and a log entry, with the author's agreement.
- `.mstack/claim-sharpen-<date>.md`.
- Summary block: the claim before and after, the framing chosen, the importance objection and its answer, the one addition.

## Anti-patterns

- **Interrogating.** Questions handed back where a proposal was owed; at most one clarifying question before proposing.
- **A menu without a recommendation.** Say which you would take and why.
- **Inflation.** Every step up the ladder names the evidence that pays for it.
- **Rescue.** Rebuilding the claim around the subgroup or specification where the effect appears.
- **Method notes.** Threats, estimators, and checks belong to `/mstack:identification-review` and `/mstack:robustness`; here they appear only as limits on what can be claimed.
- **Polishing the sentence instead of the idea.** A better-worded claim that says the same thing is not sharper.
- **Rewriting the spine unasked.**

## Next

Pre-results: `/mstack:hypothesis-design`, so the primary hypothesis is the claim in testable form. Post-results: `/mstack:argument-outline`, then `/mstack:draft-section`.
