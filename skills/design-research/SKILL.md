---
name: design-research
description: Picks design type (survey, experiment, quasi-experimental, observational) and justifies trade-offs. Use after identification-review.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# /mstack:design-research

**Stage:** design
**Voice:** design-critic

## What this skill does

Picks design type (survey, experiment, quasi-experimental, observational) and justifies trade-offs. Use after identification-review.

## Forcing questions / body

Why this design and not the others? What does this design buy you? What does it cost? What is the closest alternative and why is it worse?

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
