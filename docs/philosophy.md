# MStack philosophy

## Why this exists

Writing a paper is a long sequence of stage-specific decisions, each with its own forcing questions, failure modes, and quality bar. A "help me with my paper" prompt collapses all of those stages into one, which means Claude does whatever stage *it* thinks you're in — usually the writing stage, since that's the most token-saturated in its training. You get prose when you needed identification critique. You get a robustness check when you needed an alternative research design.

[gstack](https://github.com/garrytan/gstack) by Garry Tan noticed the same pattern in product engineering: a single AI is a worse collaborator than a small team of role-defined ones. Its fix was a sprint-shaped set of slash commands — CEO review, eng review, QA, ship — each speaking in a defined voice with defined questions. MStack is the same fix for academic research.

## The wager

Three claims:

1. **Research has stages, and the stages are real.** Idea → lit → theory → design → data → analysis → writing → submission → R&R is not arbitrary; the questions that matter at each stage don't transfer. "Is this identified?" matters at design; it's too late to ask at writing. "Is the abstract hooky?" matters at writing; it's noise at design.
2. **Role-based prompting beats free-form prompting.** A skill that says "you are a methodologist; ask these four questions" produces different — and usually better — output than "help me think about my identification strategy."
3. **Per-project memory beats per-conversation memory.** A `.mstack/` folder in the paper directory carries decisions, conventions, and prior referee reports across sessions. The paper is the unit; the chat is not.

## What MStack is not

- **Not a writing assistant.** Drafting is one stage. Most of MStack is upstream of it.
- **Not a stats package.** It defers to R conventions (the user's `r-coding-skills` skill, or MStack's bundled `references/r-conventions.md` fallback); it doesn't replace them.
- **Not a coauthor.** It simulates one (`/mstack:coauthor-review`) but is not credited.
- **Not domain-locked.** Built for political science / IPE, but the spine — ideate → map → design → build → analyze → write → submit → reflect — generalizes to most quantitative social science.

## How to read the skill set

Every skill carries a **stage** and a **voice**. Stage tells you when to use it. Voice tells you whose ear it's in.

- **Advisor / adversarial-advisor** voices are for early stages (ideate, scope-challenge). Their job is to talk you out of bad ideas.
- **Methodologist** voice runs through map, design, and analysis. Its job is to make the inference defensible.
- **Writer** voice owns the writing stage and defers to the user-configured writing-style skill (`.mstack/config.yaml` → `voice.writing_style`) for tone.
- **Referee** voice (`/mstack:referee-mock`) defers to the reviewer-style skill named in `.mstack/config.yaml` (`voice.reviewer_style`), falling back to MStack's bundled referee conventions, and front-runs the actual reviewers.
- **Replicator** voice closes the project (`/mstack:archive`) and asks: would a stranger rebuild every table from raw data?

## Defaults you should know

- **Stats stack:** R. Regenerate from `data/raw/` via numbered scripts in `code/`. Stata or Python users will need to fork or override.
- **Manuscript format:** LaTeX by default; `mstack-init --quarto` for Quarto.
- **Writing voice:** user-configurable. Set `voice.writing_style` in `.mstack/config.yaml` to the name of a writing-style skill you've installed. MStack does not ship one; leave it empty to use a generic academic voice.
- **Reviewer voice:** user-configurable (`voice.reviewer_style`); MStack ships a built-in fallback.
- **Survey work:** layered AI-completion defenses via `agent-disclosure` when installed, else MStack's bundled fallback.
- **Safety is enforced, not suggested:** `/mstack:careful` and `/mstack:freeze` (and the always-on `data/raw/` read-only rule) are backed by a `PreToolUse` hook that denies or confirms the tool call itself — they hold even in sessions that never loaded the skill.

## Failure modes MStack is built to prevent

| Failure | Skill that catches it |
|---|---|
| Spending six months on a paper that isn't a paper | `/mstack:research-question`, `/mstack:scope-challenge` |
| Discovering at submission you forgot to engage the canonical 3 papers | `/mstack:lit-map` |
| Identification problems noticed by R2 reviewer | `/mstack:identification-review` (front-runs it) |
| Forking-paths / cherry-picked specs | `/mstack:preregister`, `/mstack:robustness`, `/mstack:results-audit` |
| Sample size mismatches across tables | `/mstack:results-audit` |
| Voice drift across sections | `/mstack:draft-section` (single voice anchor) |
| Cover letter that fights the journal it's pitched to | `/mstack:journal-fit` then `/mstack:cover-letter` |
| R&R response that concedes the contribution to placate R2 | `/mstack:r-and-r` |
| Replication package that doesn't actually replicate | `/mstack:archive` (clean-room rebuild) |
| Desk reject for identifying info in a double-blind manuscript | `/mstack:submission-pack` (anonymization sweep + format checks) |
| Losing track of where the project stands between sessions | `/mstack:paper-status` (reads `.mstack/`, recommends the next skill) |
| Same lesson learned six times across six papers | `/mstack:retro` + `/mstack:learn` (writes to `.mstack/learnings.jsonl`) |
