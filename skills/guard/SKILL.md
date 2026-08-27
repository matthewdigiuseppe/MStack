---
name: guard
description: Maximum-safety mode — /mstack:careful plus /mstack:freeze in one toggle, enforced by the MStack hook.
argument-hint: "[directory]"
disable-model-invocation: true
allowed-tools:
  - Read
  - Write
  - Edit
---

# /mstack:guard

**Stage:** power
**Voice:** safety

## Argument

`$ARGUMENTS` — directory to freeze writes to (forwarded to `/mstack:freeze`). If omitted, ask which directory to lock to, as `/mstack:freeze` does.

## Procedure

1. Run the equivalent of `/mstack:careful` (set `careful: true` in `.mstack/safety.yaml`).
2. Run the equivalent of `/mstack:freeze` with the supplied path.
3. Print the combined state. Both flags are enforced by MStack's `PreToolUse` hook (`hooks/mstack-guard.py`), not just by convention: destructive commands prompt for confirmation, and writes outside the freeze path are denied.

## Outputs

- `.mstack/safety.yaml` with both `careful: true` and `freeze.path` set.
- Summary: both flags + the freeze target.

## When to call other skills

- `/mstack:unfreeze` to remove just the freeze (careful stays on).
- `/mstack:careful off` to remove just careful (freeze stays on).
