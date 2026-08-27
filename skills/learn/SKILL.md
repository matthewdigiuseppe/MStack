---
name: learn
description: Appends a paper-specific fact — variable names, conventions, design decisions, formatting preferences — to .mstack/learnings.jsonl so every later skill applies it. Use whenever the user states a convention Claude should remember, or repeats a correction twice.
argument-hint: "<fact to remember>"
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

5. **Hint at scope.** If the fact looks like it generalizes across papers (a methodological habit, a tooling preference, a writing rule), tell the user to consider also adding it to their global memory (`~/.claude/CLAUDE.md`) rather than only here.

## Outputs

- `.mstack/learnings.jsonl` — one new line.
- Summary: the new line + scope hint if applicable.

## Anti-patterns to refuse

- **Storing transient state.** "Currently working on table 3" is conversation context, not memory. Don't write it.
- **Storing what's already in code.** If the convention is encoded in a script, the script is the memory.

## When to call other skills

- If the fact crosses papers, suggest writing to global memory rather than just here.
