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

**Stage:** power
**Voice:** safety

## Procedure

1. Read `.mstack/safety.yaml`.
2. Clear `freeze.path` (remove the `freeze:` block or empty its `path`). The MStack guard hook stops denying outside writes as soon as the file no longer sets a path.
3. Print confirmation that writes are allowed everywhere again, plus the current state of `careful` (which is unchanged by `/mstack:unfreeze`).

## Outputs

- `.mstack/safety.yaml` updated.
- Summary: lock cleared; `careful` state unchanged.
