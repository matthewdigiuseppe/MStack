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

**Stage:** power · **Voice:** safety

`$ARGUMENTS` is the directory to freeze writes to (as in `/mstack:freeze`); if omitted, ask which.

## Procedure

1. Set `careful: true` in `.mstack/safety.yaml` (as `/mstack:careful` does).
2. Set `freeze.path` to the supplied directory (as `/mstack:freeze` does).
3. Print the combined state. Both are enforced by the `PreToolUse` hook (`hooks/mstack-guard.py`): destructive commands prompt for confirmation, writes outside the freeze path are denied.

## Outputs

- `.mstack/safety.yaml` with both `careful: true` and `freeze.path`; summary of both flags + the freeze target.

## Next

`/mstack:unfreeze` removes just the freeze (careful stays on); `/mstack:careful off` removes just careful (freeze stays on).
