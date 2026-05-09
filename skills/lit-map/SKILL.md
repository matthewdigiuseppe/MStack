---
name: lit-map
description: Systematic literature scan that builds a citation-graph sketch and identifies the 3–5 papers you must engage and the gap you fill. Use after you have a candidate question.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# /mstack:lit-map

**Stage:** map
**Voice:** systematic-reviewer

## What this skill does

Systematic literature scan that builds a citation-graph sketch and identifies the 3–5 papers you must engage and the gap you fill. Use after you have a candidate question.

## Forcing questions / body

Who are the 3–5 must-cite papers? What is the consensus? Where does it crack? What gap do you fill? Who would be a hostile reviewer?

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
