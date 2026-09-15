---
name: survey-build
description: Designs a Qualtrics survey instrument — blocks, question table, randomization, embedded data — with layered AI-agent/bot defenses and a probe manifest. Use whenever the user designs or programs a survey, survey experiment, or panel study, even if they never mention bot protection.
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

For a new instrument (survey experiment, panel, or a human-vs-agent benchmark study). Run before programming the Qualtrics flow, not after.

## Procedure

1. **Science target.** Read `.mstack/config.yaml`; take what is already answered in `.mstack/hypotheses.md` and `.mstack/design-research.md`, then ask the rest of the four design questions in one message: population and sample frame; treatment(s) — what is randomized, when, by whom; outcomes — primary, secondary, manipulation checks; inference unit (individual, dyad, time-series). Record in `.mstack/survey-design.md`.
2. **Bot/agent defenses**, non-optional. Use the `agent-disclosure` skill if the user has it installed, else `${CLAUDE_PLUGIN_ROOT}/references/survey-bot-defenses.md`. Either way layer: attention checks calibrated to human reading time; behavioral probes (timing distributions, paste detection, mouse-tracking opt-ins); instructional manipulation checks; open-ended quality checks; exclusion rules with thresholds. Every MStack survey ships a probe manifest.
3. **Instrument**, in `.mstack/survey-design.md`, with these sections:
   - **Block plan** with conditional logic.
   - **Question table** — per question: ID, type, wording, response options, required y/n, randomization rules, branching.
   - **Embedded data** — treatment assignment, condition labels, timing variables, IP region if collected.
   - **Probe manifest** — each probe with its trigger condition, scoring rule, and exclusion threshold.
   - **Quotas / webhooks** — the balancing logic, if balancing on demographics.
4. **Hand off to Qualtrics.** If a Qualtrics MCP is connected, offer to create the survey, blocks, and questions; otherwise produce a copy-paste-ready spec. Either way `.mstack/survey-design.md` is the reproducible record.
5. **Pre-flight.** Refuse to mark "ready to field" until: probe manifest present with a threshold on every probe; attention checks at ≤ 10% expected fail rate for engaged humans; open-ended quality protocol defined; randomization documented and reproducible; `/mstack:power-analysis` supports the N; `/mstack:preregister` run or explicitly waived. The sequence is deliberate: spec here → power → prereg (which copies the probe thresholds into its exclusions) → back here to mark ready.

## Outputs

- `.mstack/survey-design.md` — instrument spec + probe manifest.
- Optional: the survey and library blocks built in Qualtrics via MCP.

## Anti-patterns

- **No bot defenses.** Refuse and explain: agent contamination is now the default failure mode of online survey research.
- **One attention check.** Theater, not defense.
- **Ad-hoc exclusions.** Every rule pre-specified with a threshold.

## Next

`/mstack:power-analysis` and `/mstack:preregister` before fielding; `/mstack:data-acquire` then `/mstack:data-clean` (survey design as ground truth) after.
