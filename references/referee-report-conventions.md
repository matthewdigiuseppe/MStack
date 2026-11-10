# Referee-report conventions (MStack fallback)

Built-in fallback for `/mstack:referee-mock`. If the user has a reviewer-style
skill installed (named in `.mstack/config.yaml` → `voice.reviewer_style`), that
skill wins on voice and layout; this file keeps the mock report credible
without it. The caps and the bearing tags come from the skill and hold either
way.

## Structure

1. **Summary** (one paragraph). The paper's claim in the reviewer's words, not
   the abstract's, with the design and evidence behind it, and whether the
   reviewer believes it and cares. Its job is to show the editor the paper was
   read and to expose any gap between what the paper claims and what it shows.
2. **Major comments** (numbered, at most four). Issues that decide whether the
   claim is believed or how far it reaches. Each one opens with its bearing —
   **breaks** (the claim is not believed, or does not matter, until this is
   answered) or **narrows** (the claim survives in a smaller or weaker form) —
   then says what the problem is, why it matters for the inference or the
   contribution, and what would resolve it (a test, an analysis, a reframing).
   A major comment without a resolvable ask reads as a veto, not a review. A
   report with one major comment that breaks the claim is a stronger report
   than one with four that narrow it.
3. **Minor comments** (numbered, at most five), only when the author asks for
   them. Clarity, presentation, missing citations, table and figure mechanics.
   Terse is fine here.
4. **Recommendation** — Reject / Major revisions / Minor revisions / Accept —
   consistent with the majors: an unanswered `breaks` comment and "minor
   revisions" cannot coexist.

## Tone

- Professional and direct. Critique the manuscript, never the authors; no
  sarcasm, no rhetorical questions, no praise-padding before each criticism.
- One sentence of genuine positioning ("the question is well chosen", "the
  data are unusually good") is useful calibration; a paragraph of compliments
  is noise.
- Confidence proportional to expertise: flag, don't adjudicate, issues outside
  the reviewer's competence.

## Specificity

- Every substantive comment cites its target: section, page/paragraph, table,
  or figure. "More theory is needed" is not a comment; "Section 2 asserts the
  mechanism but never derives H2 from it — the moderation claim needs its own
  argument (p. 8)" is.
- Distinguish must-fix from suggestion explicitly, so the authors can triage.

## Discipline norms (political science / IPE)

- Identification scrutiny is expected, not hostile: the review names the
  identifying assumption and tests it against the design.
- Review the paper the authors wrote, not the one the reviewer would have
  written; asking for a different paper is an editor decision.
- Length: a page, two at most, single-spaced, for a first-round report.
