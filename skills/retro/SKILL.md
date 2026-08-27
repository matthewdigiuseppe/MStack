---
name: retro
description: Structured paper retrospective — timeline reconstruction plus five questions on where time went, unforced errors, surprises, wins, and the one systematizable lesson. Use after acceptance, rejection, or a major R&R round, or when the user wants to debrief a finished project.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
---

# /mstack:retro

**Stage:** reflect
**Voice:** coach

## When to invoke

After acceptance, after rejection, after a major R&R. Memory is freshest now; in a month it's gone.

## Procedure

1. **Load.** `.mstack/config.yaml` (status, target journals), the chronological set of `.mstack/*.md` files, git log of the project if available, decision letters in `submission/`.

2. **Reconstruct the timeline.**
   - First commit / `mstack-init` date.
   - Major milestones (lit-map, prereg, first analysis, first draft, submission, R1, R2, accept).
   - Approximate days between milestones.

3. **Five questions** — answer each in one paragraph. Push for specifics; vague retros are worth nothing.

   1. **Where did time actually go?** Not where you expected — where it actually went. Compare estimated vs. actual on the longest stage.
   2. **What was the biggest unforced error?** Something you did that cost time / quality and that you knew, at the time, you shouldn't be doing.
   3. **What surprised you?** A finding, a referee comment, a methodological issue, a writing block — something that wasn't on your map at the start.
   4. **What worked?** A practice / habit / decision worth keeping. The retro is also for capturing wins.
   5. **What's the one systematizable lesson?** A rule for next time. Concrete enough to operationalize as a skill, a checklist, or a global-memory entry.

4. **Save** to `.mstack/retro.md`.

5. **Promote.** If question 5 produced a lesson worth carrying across papers, suggest the user run `/mstack:learn` to write it to their global memory (not just `.mstack/learnings.jsonl`, which is paper-local).

## Outputs

- `.mstack/retro.md`.
- Summary block: timeline summary + the one systematizable lesson + suggested follow-up.

## Anti-patterns to refuse

- **Generic lessons.** "Communicate more with coauthors" is not a lesson; "set a 30-min check-in every Friday with C" is.
- **Skipping the timeline.** Without the timeline, the retro is vibes.
- **Skipping the wins.** A retro that only catalogs failures hides what to keep.

## When to call other skills

- After (optional): `/mstack:learn` to promote the lesson to global memory.
- If the lesson is "I should run /mstack:X earlier next time," record it via `/mstack:learn` and in your global memory (`~/.claude/CLAUDE.md`) — the plugin's own docs are replaced on every update, so edits there don't survive.
