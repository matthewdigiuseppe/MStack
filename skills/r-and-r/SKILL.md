---
name: r-and-r
description: Drafts response-to-reviewers with a change log that maps every reviewer comment to a manuscript change. Use during R&R.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# /mstack:r-and-r

**Stage:** submit
**Voice:** editor

## What this skill does

Drafts response-to-reviewers with a change log that maps every reviewer comment to a manuscript change. Use during R&R.

## Forcing questions / body

For each comment: quote it, respond, point to the manuscript change with line numbers. Be deferential without conceding the contribution. Track all changes in submission/response-to-reviewers/.

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
