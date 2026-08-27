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

**Stage:** power
**Voice:** safety

## Argument

`$ARGUMENTS` — the directory writes are allowed within (relative to the paper folder, e.g. `submission` or `paper/sections`). All writes outside it are denied until `/mstack:unfreeze`.

If no argument is given, do **not** set a lock. Print the current freeze state from `.mstack/safety.yaml` and ask which directory to lock to — a lock on the whole paper folder would be a no-op and give false comfort.

## How it's enforced

MStack's `PreToolUse` hook (`hooks/mstack-guard.py`) reads `.mstack/safety.yaml` before every `Write`, `Edit`, and `Bash` call. While `freeze.path` is set, writes outside that directory are **denied by the hook itself** — including in later sessions that never loaded this skill. `.mstack/` stays writable so the lock can be cleared, and `data/raw/` stays read-only regardless of the freeze.

## Procedure

1. **Read or create `.mstack/safety.yaml`.**

2. **Set the lock** (the hook parses this exact shape):

   ```yaml
   freeze:
     path: "submission"
     set_at: "YYYY-MM-DD HH:MM"
   ```

3. **Behavior while the lock is set:**
   - `Write`/`Edit` outside `freeze.path` (and outside `.mstack/`): denied by the hook.
   - Mutating `Bash` commands (`rm`, `mv`, `cp`, redirects, `sed -i`, `git reset/clean/checkout --`) whose targets resolve outside the lock: denied; when the hook can't resolve the targets, it asks for confirmation instead.
   - Reads, greps, and non-mutating commands are unaffected.

4. **Print the lock state** to the user with the absolute path of the lock target.

## Outputs

- `.mstack/safety.yaml` updated.
- Summary: lock target.

## Anti-patterns to refuse

- **Quietly working around the lock.** If a step requires a write outside, surface it and ask — don't restructure the work to dodge the hook.

## When to call other skills

- Pair with `/mstack:careful` to make `/mstack:guard`.
- Use `/mstack:unfreeze` to clear.
