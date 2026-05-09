---
name: abstract-shotgun
description: Generates 4–6 abstract variants with positioning differences. Use after a complete draft.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# /mstack:abstract-shotgun

**Stage:** write
**Voice:** writer

## What this skill does

Generates 4–6 abstract variants with positioning differences. Use after a complete draft.

## Forcing questions / body

Vary the hook (puzzle / policy / theory). Vary the headline finding emphasis. Vary the audience (IPE / comparative / methods). Tag each variant with its positioning bet.

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
