---
name: unfreeze
description: Clears the /mstack:freeze write lock; careful mode, if on, stays on.
disable-model-invocation: true
allowed-tools:
  - Read
  - Write
  - Edit
---

# /mstack:unfreeze

**Stage:** power · **Voice:** safety

## Procedure

1. Read `.mstack/safety.yaml`.
2. Remove the `freeze:` block (or empty its `path`); the guard hook stops denying outside writes as soon as no path is set.
3. Confirm writes are allowed everywhere again and report the `careful` state, which this skill does not change.

## Outputs

- `.mstack/safety.yaml` updated; summary: lock cleared, `careful` unchanged.
