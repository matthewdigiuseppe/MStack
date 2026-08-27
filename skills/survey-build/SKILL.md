---
name: survey-build
description: Designs a Qualtrics survey instrument — blocks, question table, randomization, embedded data — with layered AI-agent/bot defenses and a probe manifest baked in. Use whenever the user is designing or programming a survey, survey experiment, or panel study, even if they do not mention bot protection.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# /mstack:survey-build

**Stage:** design
**Voice:** survey-designer

## When to invoke

You're designing a new survey instrument — a survey experiment, a panel, or a benchmark study comparing humans and AI agents. Run **before** programming the Qualtrics flow, not after.

## Procedure

1. **Establish the science target.**
   - Read `.mstack/config.yaml` for paper context.
   - Ask (or read prior context for) the four design questions:
     - Population and sample frame.
     - Treatment(s) — what is randomized, when, by whom.
     - Outcome(s) — primary, secondary, manipulation checks.
     - Inference unit — individual, dyad, time-series.
   - Record the answers in `.mstack/survey-design.md`.

2. **Layer in the bot/agent defenses.**
   - Use the **agent-disclosure** skill if the user has it installed; otherwise follow `${CLAUDE_PLUGIN_ROOT}/references/survey-bot-defenses.md`. Either way, layer in:
     - Attention checks calibrated to expected human reading time.
     - Behavioral probes (timing distributions, paste-detection, mouse-tracking opt-ins).
     - Instructional manipulation checks.
     - Open-ended response quality checks.
     - Exclusion rules with thresholds.
   - This is non-optional. Every MStack survey ships with a probe manifest.

3. **Draft the instrument.** Produce, in `.mstack/survey-design.md`:
   - **Block plan** with conditional logic.
   - **Question table** — for each question: ID, type, wording, response options, required y/n, randomization rules, branching.
   - **Embedded data fields** — treatment assignment, condition labels, timing variables, IP-region (if collected).
   - **Probe manifest** (from agent-disclosure): each probe with its trigger condition, scoring rule, and exclusion threshold.
   - **Webhooks/quotas** — if balancing on demographics, document quota logic.

4. **Hand off to Qualtrics.**
   - If the user has a Qualtrics MCP connected, offer to programmatically create the survey, blocks, and questions.
   - Otherwise produce a copy-paste-ready spec the user can build manually.
   - Either way, save the spec to `.mstack/survey-design.md` so the design is reproducible.

5. **Pre-flight checklist** — refuse to mark "ready to field" until:
   - [ ] Probe manifest is present and every probe has a threshold.
   - [ ] Attention checks placed at expected fail rates ≤ 10% for engaged humans.
   - [ ] Open-ended questions have a defined quality-check protocol.
   - [ ] Treatment randomization is documented and reproducible.
   - [ ] Power analysis (`/mstack:power-analysis`) supports the proposed N.
   - [ ] Preregistration (`/mstack:preregister`) has been run or explicitly waived. The sequence is deliberate — draft the spec here, then `/mstack:power-analysis`, then `/mstack:preregister` (which copies the probe thresholds into its exclusions), then return here to mark ready-to-field.

## Outputs

- `.mstack/survey-design.md` — full instrument spec + probe manifest.
- (Optional, if Qualtrics MCP available) the actual survey + library blocks created in Qualtrics.

## Anti-patterns to refuse

- **No bot defenses.** If a user wants to skip the bot/agent defenses, refuse and explain why — agent contamination is now the default failure mode of online survey research.
- **Single attention check.** One check is not a defense; it's theater.
- **Ad-hoc exclusions.** Every exclusion rule must be pre-specified with a threshold.

## When to call other skills

- Before fielding: `/mstack:preregister`, `/mstack:power-analysis`.
- After fielding: `/mstack:data-acquire` (provenance log), then `/mstack:data-clean` (with the survey design as ground truth).
