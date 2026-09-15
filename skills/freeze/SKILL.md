---
name: freeze
description: Locks writes to a single directory — an MStack hook denies edits anywhere else in the paper folder until /mstack:unfreeze. Use during R&R to protect submission/, or to fence Claude into one part of the project.
argument-hint: "<directory>"
disable-model-invocation: true
allowed-tools:
  - Read
  - Write
  - Edit
---

# /mstack:freeze

**Stage:** power · **Voice:** safety

`$ARGUMENTS` is the directory writes stay inside, relative to the paper folder (`submission`, `paper/sections`). Without an argument do **not** lock: print the current state from `.mstack/safety.yaml` and ask which directory; a lock on the whole folder is a no-op that gives false comfort.

Enforcement is the `PreToolUse` hook (`hooks/mstack-guard.py`): while `freeze.path` is set, writes outside it are denied by the hook itself, including in later sessions that never loaded this skill. `.mstack/` stays writable so the lock can be cleared; `data/raw/` stays read-only regardless.

## Procedure

1. Read or create `.mstack/safety.yaml`.
2. Set the lock in exactly this shape:

   ```yaml
   freeze:
     path: "submission"
     set_at: "YYYY-MM-DD HH:MM"
   ```

3. Tell the user what the hook now does: `Write` / `Edit` outside the path (and outside `.mstack/`) denied; mutating Bash (`rm`, `mv`, `cp`, redirects, `sed -i`, `git reset/clean/checkout --`) with targets outside the lock denied, and asked about when the targets cannot be resolved; reads, greps, and non-mutating commands unaffected.
4. Print the lock state with the absolute path of the target.

## Outputs

- `.mstack/safety.yaml` updated; summary with the lock target.

## Anti-patterns

- **Working around the lock.** If a step needs a write outside, surface it and ask; do not restructure the work to dodge the hook.

## Next

`/mstack:unfreeze` clears it; with `/mstack:careful` it is `/mstack:guard`.
