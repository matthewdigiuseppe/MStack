---
name: robustness
description: Builds a robustness matrix — alternative specs, samples, operationalizations. Fights the "did I cherry-pick?" problem.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# /mstack:robustness

**Stage:** analyze
**Voice:** skeptical-analyst

## What this skill does

Builds a robustness matrix — alternative specs, samples, operationalizations. Fights the "did I cherry-pick?" problem.

## Forcing questions / body

For each design choice, what is the alternative? Run all reasonable variants. If results flip, the headline is wrong. Tabulate all variants in one matrix.

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
