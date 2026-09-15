---
name: survey-build
description: Designs a survey instrument or survey experiment — question wording and order, pretreatment measures, attention and manipulation checks placed correctly, vignette information equivalence, conjoint attributes and tasks, randomization mechanics, embedded data, quotas and weights — with layered AI-agent/bot defenses and a probe manifest baked in. Use whenever the user is designing or programming a survey, survey experiment, conjoint, or panel study, even if they do not mention bot protection.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# /mstack:survey-build

**Stage:** design · **Voice:** survey-designer

For a new instrument (survey experiment, panel, conjoint, or a human-vs-agent benchmark study). Run before programming the survey platform's flow, not after.

## Procedure

1. **Science target.** Read `.mstack/config.yaml`, `.mstack/hypotheses.md` (estimands, moderators), `.mstack/design-research.md`, and `${CLAUDE_PLUGIN_ROOT}/references/survey-design-conventions.md`; take what those already answer, then ask the rest of the design questions in one message: population and sample frame; treatment(s), what is randomized, when, by whom, and the assignment scheme; outcomes (primary, secondary, manipulation checks) and how each is scored; inference unit; moderators to be measured pre-treatment. Record the answers in `.mstack/survey-design.md`.
2. **Bot/agent defenses**, non-optional. Use the `agent-disclosure` skill if the user has it installed, else `${CLAUDE_PLUGIN_ROOT}/references/survey-bot-defenses.md`. Either way layer: attention checks calibrated to human reading time; behavioral probes (timing distributions, paste detection, mouse-tracking opt-ins); instructional manipulation checks; open-ended quality checks; exclusion rules with thresholds. Every MStack survey ships a probe manifest.
3. **Instrument**, in `.mstack/survey-design.md`, with these sections:
   - **Block plan** with conditional logic, in this order: consent; screeners and pre-treatment attention checks; pre-treatment covariates and moderators; prior exposure to the treatment (pretreatment); the treatment; the primary outcome immediately after; secondary outcomes; manipulation check; open-ended item; demographics; disclosure item and debrief.
   - **Question table** — per question: ID, type, exact wording, response options with labels, required y/n, randomization rules, branching, and the construct it measures; wording rules from the conventions file (single-barreled, balanced, no agree/disagree batteries, fully labeled scales).
   - **Experimental design** — for vignettes, the arms with information equivalence argued and pretested; for conjoints, attributes and levels, restrictions, number of tasks, forced choice plus rating, attribute-order randomization; for sensitive-item designs, the control and treatment lists.
   - **Embedded data** — assignment, condition labels, timing per page, device, referrer, quota cell, IP region if collected, the probe outcomes.
   - **Probe manifest** — each probe with its trigger condition, scoring rule, and exclusion threshold.
   - **Sampling** — provider, quotas or weights, incentives, screeners, recruitment dates, IRB number, consent and debrief text.
   - **Pilot plan** — 50–100 completes to calibrate timing, attention-check fail rates, and floor or ceiling effects, with what would change the instrument.
4. **Hand off to the platform.** If a Qualtrics MCP is connected, offer to create the survey, blocks, and questions; otherwise produce a copy-paste-ready spec. Either way `.mstack/survey-design.md` is the reproducible record.
5. **Pre-flight.** Refuse to mark "ready to field" until: probe manifest present with a threshold on every probe; attention checks pre-treatment or not used as post-treatment exclusions, at ≤ 10% expected fail rate for engaged humans; the manipulation check is not an exclusion criterion; open-ended quality protocol defined; randomization documented, reproducible, and written to embedded data; vignette information equivalence pretested; the pilot has run or is scheduled; `/mstack:power-analysis` supports the N in profiles and respondents; `/mstack:preregister` run or explicitly waived. The sequence is deliberate: spec here → power → prereg (which copies the probe thresholds into its exclusions) → pilot → back here to mark ready.

## Outputs

- `.mstack/survey-design.md` — instrument spec, experimental design, probe manifest, sampling and pilot plans.
- Optional: the survey and library blocks built in Qualtrics via MCP.

## Anti-patterns

- **No bot defenses.** Refuse and explain: agent contamination is now the default failure mode of online survey research.
- **One attention check.** Theater, not defense.
- **Post-treatment exclusions.** Dropping respondents on a manipulation check or a post-treatment attention check selects on a consequence of treatment.
- **Compound vignettes.** An arm that changes what respondents infer about other attributes is two treatments.
- **Ad-hoc exclusions.** Every rule pre-specified with a threshold.

## Next

`/mstack:power-analysis` and `/mstack:preregister` before fielding; `/mstack:data-acquire` then `/mstack:data-clean` (survey design as ground truth) after.
