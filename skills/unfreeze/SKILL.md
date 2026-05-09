---
name: unfreeze
description: Remove the edit lock set by /freeze. Confirms that writes outside the locked directory are allowed again.
user-invocable: true
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
2. Clear `freeze.path`.
3. Print confirmation that writes are allowed everywhere again, plus the current state of `careful` (which is unchanged by `/unfreeze`).

## Outputs

- `.mstack/safety.yaml` updated.
- Summary: lock cleared; `careful` state unchanged.
