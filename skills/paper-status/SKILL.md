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

   It finds `.mstack/` at or above the current directory (exit 1 and a pointer to `/mstack:mstack-init` if there is none), reads `.mstack/config.yaml`, and prints: every pipeline artifact by stage with its state (present / stub / missing / optional), date, and verdict line; verdicts that are stale because an input changed after they were written (a results audit older than `code/02-analyze.R`, an identification review older than `methods.tex`, a lit map older than `lit/index.md`, PDFs dropped in `lit/pdf/` but never ingested); the stage the artifacts imply; whether that matches `paper.status`; and the required artifacts still missing up to that stage. Do not re-derive any of this with your own globs and greps; open a file only when its verdict line is not enough to explain it.
2. **Reconcile `paper.status`.** If the script reports a mismatch, say so and offer to update the field in `.mstack/config.yaml`.
3. **Recommend exactly one next step:** the earliest required gap wins over a shinier later stage, and a stale verdict counts as a gap. Name the skill and the reason in one sentence.

## Outputs

- A printed report: the config line, the per-stage table, stale flags, the one next skill. No files written.
- With consent only: `paper.status` corrected in `.mstack/config.yaml`.

## Anti-patterns

- **Guessing the stage from the conversation.** The artifacts on disk are the record, and the script reads them.
- **Three next steps.** One; the pipeline is ordered for a reason.
- **A stub counted as done.** The script strips template comments before deciding; trust its `stub` state.
