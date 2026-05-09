---
name: draft-section
description: Drafts a paper section in voice — intro, theory, data, methods, results, discussion. Wraps digiuseppe-writing-style. Section name as argument.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# /mstack:draft-section

**Stage:** write
**Voice:** writer

## What this skill does

Drafts a paper section in voice — intro, theory, data, methods, results, discussion. Wraps digiuseppe-writing-style. Section name as argument.

## Forcing questions / body

Use the digiuseppe-writing-style skill for voice. Write to paper/sections/<section>.tex. Cite from refs.bib. Do not fabricate citations — flag missing references for the user.

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
