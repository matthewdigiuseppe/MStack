---
name: scope-challenge
description: Adversarial advisor voice that challenges scope. "Is this a paper or a footnote?" Use when a project is sprawling or you suspect you're writing a book chapter, not a journal article.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# /mstack:scope-challenge

**Stage:** ideate
**Voice:** adversarial-advisor

## What this skill does

Adversarial advisor voice that challenges scope. "Is this a paper or a footnote?" Use when a project is sprawling or you suspect you're writing a book chapter, not a journal article.

## Forcing questions / body

Is this one paper or three? What is the smallest defensible contribution? What would you cut if you had to ship in 3 months?

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
