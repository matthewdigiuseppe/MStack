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

**Stage:** power · **Voice:** safety

A mechanism, not a promise: the `PreToolUse` hook (`hooks/mstack-guard.py`) runs before every `Write`, `Edit`, and `Bash` call, and while `.mstack/safety.yaml` has `careful: true` the actions below become confirmation prompts, even in a fresh session that never loaded this skill.

## Procedure

1. Read or create `.mstack/safety.yaml` (default `careful: false`).
2. Set the top-level line `careful: true` (or `false` if `$ARGUMENTS` is `off`); the hook parses exactly this shape.
3. Tell the user what now prompts for confirmation:
   - `rm`, `git reset --hard`, `git checkout --`, `git clean -f`, force push, `sed -i`, `truncate`;
   - `mv` touching `paper/`, `output/`, `submission/`, or `prereg/`;
   - `Write` replacing an existing non-empty file under those directories, or any existing file of 100+ lines.
   Reads, greps, targeted `Edit`s, and writes to `.mstack/`, `code/`, and non-raw `data/` proceed normally; `data/raw/` is protected at all times, independent of this toggle.
4. Print the state: careful mode `<on|off>`, enforced by the MStack guard hook.

## Outputs

- `.mstack/safety.yaml` updated; summary of the current state.

## Anti-patterns

- **Bypassing while on.** A confirmed prompt covers that command only; never flip the flag off to avoid future prompts unless the user runs `/mstack:careful off`.

## Next

Pair with `/mstack:freeze`; both together is `/mstack:guard`.
