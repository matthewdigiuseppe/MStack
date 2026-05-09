---
name: theory-build
description: Builds the formal mechanism, draws a DAG, specifies scope conditions. Use after lit-map, before hypothesis-design.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# /mstack:theory-build

**Stage:** map
**Voice:** theorist

## What this skill does

Builds the formal mechanism, draws a DAG, specifies scope conditions. Use after lit-map, before hypothesis-design.

## Forcing questions / body

What is the mechanism in one sentence? What is the DAG? What are the scope conditions? What would the theory predict in cases not in your data?

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
