---
name: referee-mock
description: Mock R1 referee report. Wraps journal-reviewer-style. Use before submission.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# /mstack:referee-mock

**Stage:** write
**Voice:** referee

## What this skill does

Mock R1 referee report. Wraps journal-reviewer-style. Use before submission.

## Forcing questions / body

Use the journal-reviewer-style skill for voice. Produce a referee report with summary, major comments, minor comments, recommendation. Be the reviewer you fear.

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
