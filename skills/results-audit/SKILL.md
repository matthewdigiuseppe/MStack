---
name: results-audit
description: Staff-statistician review of the analysis. Catches off-by-one, sample mismatches, p-hacking risk, multiple-comparisons gaps. Analog to gstack's /review.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# /mstack:results-audit

**Stage:** analyze
**Voice:** staff-statistician

## What this skill does

Staff-statistician review of the analysis. Catches off-by-one, sample mismatches, p-hacking risk, multiple-comparisons gaps. Analog to gstack's /review.

## Forcing questions / body

Sample sizes match across tables? SE clustering matches design? Multiple comparisons accounted for? Robustness checks aligned with main spec? Any garden-of-forking-paths exposure?

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
