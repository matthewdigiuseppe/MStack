---
name: careful
description: Toggles warn-before-destructive mode for this paper — an MStack hook then requires confirmation before rm, git reset, force-push, or overwriting manuscript/output files. Use near deadlines or before autonomous work on a submission-ready paper; run with argument off to disable.
argument-hint: "[off]"
disable-model-invocation: true
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

## How it's enforced

This is not a promise — it's a mechanism. MStack ships a `PreToolUse` hook (`hooks/mstack-guard.py`) that runs before every `Write`, `Edit`, and `Bash` call. When `.mstack/safety.yaml` has `careful: true`, the hook turns the actions below into an explicit confirmation prompt, so they cannot run silently even in a fresh session that never loaded this skill.

## Procedure

1. **Read or create `.mstack/safety.yaml`** in the current paper folder. If missing, create with default `careful: false`.

2. **Toggle.** Flip `careful` to `true` (or `false` if `$ARGUMENTS` is `off`). Write the flag as a top-level `careful: true|false` line — the hook parses this file.

3. **What the hook intercepts while `careful: true`** (each becomes a confirm-first prompt):
   - `rm`, `git reset --hard`, `git checkout --`, `git clean -f`, force push, `sed -i`, `truncate`.
   - `mv` touching `paper/`, `output/`, `submission/`, or `prereg/`.
   - `Write` that would replace an existing non-empty file under `paper/`, `output/`, `submission/`, `prereg/`, or any existing file of 100+ lines.
   - Reads, greps, targeted `Edit`s, and writes to `.mstack/`, `code/`, and `data/` (non-raw) proceed normally. (`data/raw/` is protected by the hook at all times, independent of this toggle.)

4. **Print the current state** to the user: `careful` mode is now `<on|off>`, enforced by the MStack guard hook.

## Outputs

- `.mstack/safety.yaml` updated.
- Summary block: current state.

## Anti-patterns to refuse

- **Bypassing while careful is on.** If the user confirms a prompted command, that approval covers that command only — don't flip the flag off to avoid future prompts unless the user runs `/mstack:careful off`.

## When to call other skills

- Pair with `/mstack:freeze` for stricter lockdown — that becomes `/mstack:guard`.
