---
name: paper-status
description: Reports where a paper stands from its .mstack/ memory and pipeline outputs — stage, missing artifacts, stale verdicts, and the one recommended next skill. Use when the user asks where they left off or what's next, wants a status check, or opens a session on an existing paper.
allowed-tools:
  - Bash(python3 *)
  - Read
  - Grep
  - Glob
  - Edit
---

# /mstack:paper-status

**Stage:** any · **Voice:** project-manager

Opening a session, returning after a gap, "where were we?", "what's next?". Read-only apart from an offered `paper.status` correction.

## Procedure

1. **Inventory in one call:**

   ```bash
   python3 "${CLAUDE_PLUGIN_ROOT}/bin/mstack-status"
   ```

   It finds `.mstack/` at or above the current directory (exit 1 and a pointer to `/mstack:mstack-init` if there is none), reads `.mstack/config.yaml`, and prints: every pipeline artifact by stage with its state (present / thin / stub / missing / optional), date, and verdict line, where `thin` means the file exists but is too small or too repetitive to be a real artifact of its kind; verdicts that are stale because an input changed after they were written (a results audit older than `code/02-analyze.R`, an identification review older than `methods.tex`, a lit map older than `lit/index.md`, PDFs dropped in `lit/pdf/` but never ingested); the stage the artifacts imply; whether that matches `paper.status`; and the required artifacts still missing up to that stage. Do not re-derive any of this with your own globs and greps.
2. **Spot-check what the verdict rests on.** Open every artifact the script marks `thin`, and the one `present` artifact that anchors the derived stage (the furthest one). If any of them is placeholder text, say so and derive the stage yourself from the last real artifact; the script's heuristics are size and repetition, and your reading beats them.
3. **Reconcile `paper.status`.** If the script's derived stage, or your corrected one, disagrees with config, say so and offer to update the field in `.mstack/config.yaml`; never change it unasked.
4. **Recommend exactly one next step:** the earliest required gap wins over a shinier later stage, and a stale verdict counts as a gap. Name the skill and the reason in one sentence.

## Outputs

A printed report, in this order, and nothing written to the paper folder:

1. **Bottom line, four short sentences (under 80 words):** the stage and whether it matches `paper.status`; what is stale; the one next skill and why.
2. **One per-stage table**, the script's rows with your spot-check corrections already applied (state, date, verdict or a short note). One table is the inventory; do not paste raw script output and then re-summarize it.
3. **Only what changes the next step:** a placeholder you found behind a `present` or `thin` label, a mismatch to correct. Observations that do not change the recommendation stay out.

Write for the author, not about the process: no "the script says", no state-versus-correction columns, no mention of which heuristic decided what. Report the corrected state and, where you overrode the script, one short note in the row.

With consent only: `paper.status` corrected in `.mstack/config.yaml`.

## Anti-patterns

- **Guessing the stage from the conversation.** The artifacts on disk are the record, and the script reads them.
- **Three next steps.** One; the pipeline is ordered for a reason.
- **A stub counted as done.** The script strips template comments before deciding; trust its `stub` state, open anything it calls `thin`, and spot-check the artifact the stage rests on.
- **A report longer than the paper's problems.** Bottom line, one table, then only what changes the next step.
