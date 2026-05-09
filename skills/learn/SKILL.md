---
name: learn
description: Append a per-paper convention or fact to .mstack/learnings.jsonl. Use to teach Claude variable names, design choices, framing, target-journal preferences. One JSON object per line — append-only.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash(date *)
---

# /mstack:learn

**Stage:** power
**Voice:** memory

## When to invoke

Whenever you find yourself telling Claude the same paper-specific fact twice. The convention belongs in the paper's memory, not in your head.

## Argument

`$ARGUMENTS` — the fact to remember. Free-form text; this skill will normalize it.

## Procedure

1. **Classify the fact** into one of:
   - `variable_name` — naming convention for a key variable.
   - `convention` — analytical / coding convention specific to this paper.
   - `decision` — a design or framing decision (with rationale).
   - `preference` — output / formatting / style preference.
   - `reference` — pointer to an external resource specific to this paper.
   - `other` — free-form.

2. **Normalize.** Strip whitespace; trim trailing punctuation; capitalize the sentence.

3. **Append a JSON line** to `.mstack/learnings.jsonl`:

   ```json
   {"date":"YYYY-MM-DD","kind":"<class>","fact":"<normalized fact>"}
   ```

4. **Echo back** what was written so the user can confirm.

5. **Hint at scope.** If the fact looks like it generalizes across papers (a methodological habit, a tooling preference, a writing rule), tell the user to consider also writing it to global memory at `~/.claude/projects/.../memory/` rather than only here.

## Outputs

- `.mstack/learnings.jsonl` — one new line.
- Summary: the new line + scope hint if applicable.

## Anti-patterns to refuse

- **Storing transient state.** "Currently working on table 3" is conversation context, not memory. Don't write it.
- **Storing what's already in code.** If the convention is encoded in a script, the script is the memory.

## When to call other skills

- If the fact crosses papers, suggest writing to global memory rather than just here.
