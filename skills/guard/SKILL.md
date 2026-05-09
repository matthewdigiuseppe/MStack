---
name: guard
description: /careful + /freeze combined in one toggle. Maximum-safety mode. Lifted from gstack's /guard.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
---

# /mstack:guard

**Stage:** power
**Voice:** safety

## Argument

`$ARGUMENTS` — directory to freeze writes to (forwarded to `/freeze`).

## Procedure

1. Run the equivalent of `/careful` (toggle `careful: true` in `.mstack/safety.yaml`).
2. Run the equivalent of `/freeze` with the supplied path (or paper-folder root if none).
3. Print the combined state.

## Outputs

- `.mstack/safety.yaml` with both `careful: true` and `freeze.path` set.
- Summary: both flags + the freeze target.

## When to call other skills

- `/unfreeze` to remove just the freeze (careful stays on).
- `/careful off` to remove just careful (freeze stays on).
