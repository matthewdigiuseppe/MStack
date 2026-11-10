# MStack philosophy

## Why this exists

Writing a paper is a long sequence of stage-specific decisions, each with its own forcing questions, failure modes, and quality bar. A "help me with my paper" prompt collapses all of those stages into one, which means Claude does whatever stage *it* thinks you're in — usually the writing stage, since that's the most token-saturated in its training. You get prose when you needed identification critique. You get a robustness check when you needed an alternative research design.

[gstack](https://github.com/garrytan/gstack) by Garry Tan noticed the same pattern in product engineering: a single AI is a worse collaborator than a small team of role-defined ones. Its fix was a sprint-shaped set of slash commands — CEO review, eng review, QA, ship — each speaking in a defined voice with defined questions. MStack is the same fix for academic research.

## The wager

Three claims:

1. **Research has stages, and the stages are real.** Idea → lit → theory → design → data → analysis → writing → submission → R&R is not arbitrary; the questions that matter at each stage don't transfer. "Is this identified?" matters at design; it's too late to ask at writing. "Is the abstract hooky?" matters at writing; it's noise at design.
2. **Role-based prompting beats free-form prompting.** A skill that says "you are a methodologist; ask these four questions" produces different — and usually better — output than "help me think about my identification strategy."
3. **Per-project memory beats per-conversation memory.** A `.mstack/` folder in the paper directory carries decisions, conventions, and prior referee reports across sessions. The paper is the unit; the chat is not.
4. **The claim is the unit of relevance.** Stages and roles make an assistant thorough, and thoroughness has a failure of its own: a review with forty comments of equal weight, an audit that reports every check at the same volume, a next step that is whichever file is missing. A paper is an argument for one claim. `.mstack/spine.md` states it in five lines, every skill reads it first, and what a skill produces is ranked by what it does to that claim: breaks it, narrows it, or leaves it untouched. The idea is also the one thing that is not a stage. It is written at ideation, pushed after the theory, and restated after the results, because the paper found is rarely the paper planned.

## What MStack is not

- **Not a writing assistant.** Drafting is one stage. Most of MStack is upstream of it.
- **Not a stats package.** It defers to R conventions (the user's `r-coding-skills` skill, or MStack's bundled `references/r-conventions.md` fallback); it doesn't replace them. It does carry the methodological standards a reviewer will hold the paper to (`references/identification-threats.md`, `estimation-conventions.md`, `robustness-protocols.md`, and the rest of the reference library) so that the skills argue from the discipline's canon rather than from a generic checklist.
- **Not a credited coauthor.** It simulates one's read of a draft (`/mstack:coauthor-review`) and does one's work on the idea (`/mstack:claim-sharpen`, the one skill that proposes rather than interrogates), but the author decides every change to the claim and is the author.
- **Not domain-locked.** Built for political science / IPE, but the spine — ideate → map → design → build → analyze → write → submit → reflect — generalizes to most quantitative social science.

## How to read the skill set

Every skill carries a **stage** and a **voice**. Stage tells you when to use it. Voice tells you whose ear it's in.

- **Advisor / adversarial-advisor** voices are for early stages (ideate, scope-challenge). Their job is to talk you out of bad ideas.
- **Coauthor** voice (`/mstack:claim-sharpen`) works on the idea itself, before data and again after results: the strongest claim the evidence pays for, what it is a case of, how else it could be framed. It proposes; the others ask.
- **Methodologist** voice runs through map, design, and analysis. Its job is to make the inference defensible, and to say what each threat would do to the claim.
- **Structural editor** voice (`/mstack:argument-outline`) turns the claim into the three or four supporting claims the paper needs and sends everything else to the appendix or out.
- **Writer** voice owns the writing stage, drafts from that outline, and defers to the user-configured writing-style skill (`.mstack/config.yaml` → `voice.writing_style`) for tone.
- **Referee** voice (`/mstack:referee-mock`) asks for the target journal first and writes as a panel of five reviewer types drawn from that journal's pool. Tone defers to the reviewer-style skill named in `.mstack/config.yaml` (`voice.reviewer_style`), falling back to MStack's bundled referee conventions. It front-runs the actual reviewers.
- **Replicator** voice closes the project (`/mstack:archive`) and asks: would a stranger rebuild every table from raw data?

## Defaults you should know

- **Stats stack:** R. Regenerate from `data/raw/` via numbered scripts in `code/`. Stata or Python users will need to fork or override.
- **Manuscript format:** LaTeX by default; `mstack-init --quarto` for Quarto.
- **Writing voice:** user-configurable. Set `voice.writing_style` in `.mstack/config.yaml` to the name of a writing-style skill you've installed. MStack does not ship one; leave it empty to use a generic academic voice.
- **Reviewer voice:** user-configurable (`voice.reviewer_style`); MStack ships a built-in fallback.
- **Survey work:** layered AI-completion defenses via `agent-disclosure` when installed, else MStack's bundled fallback.
- **The main idea is in front of every session:** a `SessionStart` hook prints `.mstack/spine.md` into context whenever Claude Code opens, resumes, clears, or compacts inside a paper folder.
- **Reviews are short by default:** at most four major comments per mock referee, each tagged `breaks` or `narrows`; minor comments and line edits are opt-in (`minor`, `lines`).
- **Safety is enforced, not suggested:** `/mstack:careful` and `/mstack:freeze` (and the always-on `data/raw/` read-only rule) are backed by a `PreToolUse` hook that denies or confirms the tool call itself — they hold even in sessions that never loaded the skill.

## Failure modes MStack is built to prevent

| Failure | Skill that catches it |
|---|---|
| Feedback that circles the paper's edges and never touches its main idea | `.mstack/spine.md`, loaded first by every skill; comments capped and ranked by bearing on the claim |
| A draft whose reader comes away with a different claim from the author's | The comprehension test in `/mstack:coauthor-review` and `/mstack:referee-mock` |
| A paper framed around the plan rather than what was found | `/mstack:claim-sharpen` after results (framing moves; preregistered hypotheses do not) |
| A claim smaller than the evidence, or a finding with no "so what" | `/mstack:claim-sharpen` (the ladder of claims, the importance objection) |
| Sections full of what such sections usually contain | `/mstack:argument-outline`, then `/mstack:draft-section` from it |
| A to-do list driven by missing files rather than by the argument | `/mstack:paper-status` (the weakest link) |
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
| A hypothesis with no estimand, so nothing could falsify it | `/mstack:hypothesis-design` (estimand, smallest effect of interest, decision rule) |
| A theory never compared with the reverse-causal story | `/mstack:theory-build` (rival mechanisms with separating implications) |
| Two-way fixed effects under staggered adoption; logit coefficients compared across models; an interaction read off its coefficient | `/mstack:analyze` + `/mstack:results-audit` (via `references/estimation-conventions.md`) |
| A preregistration that constrains nothing | `/mstack:preregister` (the two-researchers test) |
| Data merged on country names; a lag across a panel gap; Polity's −66/−77/−88 treated as scores | `/mstack:data-clean` + `/mstack:results-audit` (via `references/polisci-data-sources.md` and `audit-catalog.md`) |
| A null reported as "no effect" | `/mstack:draft-section` (nulls read against the SESOI) |
| Robustness that never asks how strong a confounder would have to be | `/mstack:robustness` (the sensitivity sentence) |
