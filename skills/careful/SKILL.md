---
name: careful
description: Warn before destructive commands. Lifted from gstack's /careful. Toggle on when working with manuscript files near a deadline.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# /mstack:careful

**Stage:** power
**Voice:** safety

## What this skill does

Warn before destructive commands. Lifted from gstack's /careful. Toggle on when working with manuscript files near a deadline.

## Forcing questions / body

Before any rm, mv, git reset, or overwrite of paper/, output/, or submission/: stop, summarize, and ask.

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
