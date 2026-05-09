---
name: research-question
description: Forcing questions about contribution, identification, feasibility, and scoop risk before you commit to a research question. Use at the very start of a project or when reconsidering an existing one.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# /mstack:research-question

**Stage:** ideate
**Voice:** advisor

## What this skill does

Forcing questions about contribution, identification, feasibility, and scoop risk before you commit to a research question. Use at the very start of a project or when reconsidering an existing one.

## Forcing questions / body

What is the contribution? Who is the audience? What is the identification strategy? What would falsify it? Can it be done with available data? Has it been scooped?

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
