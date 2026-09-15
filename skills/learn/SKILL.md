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

**Stage:** power · **Voice:** memory

For any paper-specific fact the user has had to say twice; it belongs in the paper's memory, not their head. `$ARGUMENTS` is the fact, free-form.

## Procedure

1. **Classify:** `variable_name`, `convention` (analytical / coding, specific to this paper), `decision` (design or framing, with rationale), `preference` (output / formatting / style), `reference` (an external resource), or `other`.
2. **Normalize:** trim whitespace and trailing punctuation; capitalize the sentence.
3. **Append** one line to `.mstack/learnings.jsonl`:

   ```json
   {"date":"YYYY-MM-DD","kind":"<class>","fact":"<normalized fact>"}
   ```

4. **Echo** the line so the user can confirm.
5. **Scope hint.** If the fact generalizes across papers (a methods habit, a tooling preference, a writing rule), suggest also adding it to global memory (`~/.claude/CLAUDE.md`) rather than only here.

## Outputs

- `.mstack/learnings.jsonl` — one new line; summary with the scope hint if any.

## Anti-patterns

- **Transient state.** "Currently working on table 3" is conversation, not memory.
- **What the code already encodes.** The script is the memory.
