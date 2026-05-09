---
name: survey-build
description: Scaffolds a Qualtrics survey with bot-defense baked in. Wraps the agent-disclosure skill. Use when designing any new survey instrument.
user-invocable: true
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

## What this skill does

Scaffolds a Qualtrics survey with bot-defense baked in. Wraps the agent-disclosure skill. Use when designing any new survey instrument.

## Forcing questions / body

Use the agent-disclosure skill to layer in attention checks, behavioral probes, and exclusion rules. Build a probe manifest alongside the instrument.

## How it interacts with the paper folder

This skill assumes the standard MStack paper layout (`mstack-init` scaffolds it):

```
.mstack/         # config + learnings + caches
paper/           # manuscript + sections/
data/{raw,clean} # raw is read-only; clean is generated
code/            # numbered R scripts
output/          # tables + figures
submission/      # cover letter + R&R
prereg/          # preregistration docs
```

Read `.mstack/config.yaml` for paper-level context (title, target journals, coauthors). Read `.mstack/learnings.jsonl` for paper-specific conventions.

## Output

<!-- Stub. Fill in: where outputs go, what files this skill writes, what it never touches. -->

## TODO (Phase 2/3 build-out)

- [ ] Flesh out the prompt — turn the forcing questions above into a concrete script.
- [ ] Define exact output paths and filenames.
- [ ] Add examples of good and bad outputs.
