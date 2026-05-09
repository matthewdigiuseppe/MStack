---
name: preregister
description: Drafts an OSF / AsPredicted preregistration document. Use before any data collection or analysis on a new sample.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# /mstack:preregister

**Stage:** design
**Voice:** preregistration-clerk

## What this skill does

Drafts an OSF / AsPredicted preregistration document. Use before any data collection or analysis on a new sample.

## Forcing questions / body

Hypotheses, sample, exclusions, measures, primary analysis, secondary analysis, robustness, deviations policy. Fill every section — gaps are red flags.

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
