---
name: careful
description: Toggle a "warn before destructive commands" mode for this project. When enabled, Claude must summarize and ask before running rm, mv, git reset, force-push, or overwriting files in paper/, output/, submission/. Lifted from gstack's /careful.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
---

# /mstack:careful

**Stage:** power
**Voice:** safety

## When to invoke

Near a deadline. After a major edit you don't want clobbered. Before letting Claude work autonomously on a paper that's about to be submitted.

## Procedure

1. **Read or create `.mstack/safety.yaml`** in the current paper folder. If missing, create with default `careful: false`.

2. **Toggle.** Flip `careful` to `true` (or `false` if `$ARGUMENTS` is `off`).

3. **Behavior change while `careful: true`:**
   - Before any of these actions, Claude **must** summarize the action and ask the user to confirm:
     - `rm`, `rm -rf`.
     - `mv` of files in `paper/`, `output/`, `submission/`, `prereg/`.
     - Overwriting any non-empty file under `paper/`, `output/`, `submission/`, `prereg/`.
     - `git reset --hard`, `git checkout --`, `git clean -f`, force push.
     - Any `Write`/`Edit` that would clobber a file ≥ 100 lines.
   - Read-only operations and edits to `.mstack/`, `code/`, and `data/` (non-raw) proceed normally.

4. **Print the current state** to the user: `careful` mode is now `<on|off>`.

## Outputs

- `.mstack/safety.yaml` updated.
- Summary block: current state.

## Anti-patterns to refuse

- **Bypassing while careful is on.** If the user asks to bypass for one command, do it for that command only and re-engage. Don't silently disable.

## When to call other skills

- Pair with `/freeze` for stricter lockdown — that becomes `/guard`.
