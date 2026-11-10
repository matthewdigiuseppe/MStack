---
name: paper-status
description: Reports where a paper stands from its .mstack/ memory and pipeline outputs — the main idea as recorded in the spine, the stage, stale verdicts, the weakest link in the argument for the claim, and the one next skill that would repair or establish it. Use when the user asks where they left off or what's next, wants a status check, or opens a session on an existing paper.
allowed-tools:
  - Bash(python3 *)
  - Read
  - Grep
  - Glob
  - Edit
---

# /mstack:paper-status

**Stage:** any · **Voice:** project-manager

Opening a session, returning after a gap, "where were we?", "what's next?". Read-only apart from an offered `paper.status` correction. The question it answers is where the argument for the claim is weakest, which is rarely the same as which file is missing.

## Procedure

1. **Inventory in one call:**

   ```bash
   python3 "${CLAUDE_PLUGIN_ROOT}/bin/mstack-status"
   ```

   It finds `.mstack/` at or above the current directory (exit 1 and a pointer to `/mstack:mstack-init` if there is none), reads `.mstack/config.yaml`, and prints: the five lines of `.mstack/spine.md` and its last change; every pipeline artifact by stage with its state (present / thin / stub / missing / optional), date, and verdict line, where `thin` means the file exists but is too small or too repetitive to be a real artifact of its kind; verdicts that are stale because an input changed after they were written (a results audit older than `code/02-analyze.R`, a spine older than the results audit, an outline older than the spine, PDFs dropped in `lit/pdf/` but never ingested); the stage the artifacts imply and whether it matches `paper.status`; and the **argument chain**: nine links a reader has to accept for the claim to land (stated, new, derived, identified, estimated, robust, current, organized, received), each rated holds / weak / broken / stale / open from the verdict that speaks to it, with the weakest link and the skill that addresses it. Do not re-derive any of this with your own globs and greps.
2. **Spot-check what the verdict rests on.** Open every artifact the script marks `thin`, the artifact behind the weakest link, and any link the script rates `unrated`. If one is placeholder text, or its verdict line says something other than what the script read, correct the link's state yourself; the script reads sizes, dates, and one line per file, and your reading beats it.
3. **Reconcile `paper.status`.** If the script's derived stage, or your corrected one, disagrees with config, say so and offer to update the field in `.mstack/config.yaml`; never change it unasked.
4. **Recommend exactly one next step: the weakest link in the argument.** A broken link comes first, wherever it sits, since everything downstream rests on it. Then the earliest link that is stale or not yet established; when a required artifact of an earlier stage stands between the paper and that link, the artifact is the step (the script names it). Once every link has been tested, the earliest weak one, unless the author has already answered it as far as it can be answered, in which case the earliest remaining gap. A missing artifact that no link depends on is housekeeping: list it, do not lead with it. Name the skill and the reason in one sentence, in terms of the claim.

## Outputs

A printed report, in this order, and nothing written to the paper folder:

1. **The claim**, as the spine has it, in one line, and the config line as the script prints it: title, `paper.status`, format, design, prereg, target journals. With no claim in the spine, say so first; writing one is then the next step.
2. **Bottom line, four short sentences (under 80 words):** the stage and whether it matches `paper.status`; the weakest link and what it means for the claim; which verdicts are stale (an input changed after they were written; a placeholder is a gap, not a stale verdict); the one next skill and why.
3. **The argument chain** as one table: link, state, the evidence in a few words, your spot-check corrections already applied.
4. **One per-stage table** of artifacts, the script's rows with your corrections applied (state, date, verdict or a short note). Do not paste raw script output and then re-summarize it.
5. **Only what changes the next step:** a placeholder you found behind a `present` or `thin` label, a mismatch to correct. Observations that do not change the recommendation stay out.

Write for the author, not about the process: no "the script says", no state-versus-correction columns, no mention of which heuristic decided what. Report the corrected state and, where you overrode the script, one short note in the row.

With consent only: `paper.status` corrected in `.mstack/config.yaml`.

## Anti-patterns

- **Guessing the stage from the conversation.** The artifacts on disk are the record, and the script reads them.
- **Three next steps.** One.
- **Leading with a missing file.** The next step is the link of the argument that most needs work; a missing artifact matters when it is on the way there.
- **A stub counted as done.** The script strips template comments before deciding; trust its `stub` state, open anything it calls `thin`, and spot-check the artifact the weakest link rests on.
- **A report longer than the paper's problems.** Claim, bottom line, two tables, then only what changes the next step.
