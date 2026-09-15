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

**Stage:** reflect · **Voice:** coach

After acceptance, rejection, or a major R&R, while memory is fresh.

## Procedure

1. **Load** the dated artifact table from `python3 "${CLAUDE_PLUGIN_ROOT}/bin/mstack-status"` (every verdict with its date), `git log --reverse --date=short --format='%ad %s'` if the project is a git repo, and the decision letters in `submission/response-to-reviewers/`. Then read the `.mstack/*.md` memos and referee reports in date order; the retro is only as good as the record it reads.
2. **Timeline:** first commit / `mstack-init` date; milestones (lit-map, prereg, first analysis, first draft, submission, R1, R2, accept); approximate days between them.
3. **Five questions**, one paragraph each; push for specifics, vague retros are worth nothing:
   1. **Where did time actually go?** Estimated vs. actual on the longest stage.
   2. **The biggest unforced error?** Something that cost time or quality and that you knew at the time you should not be doing.
   3. **What surprised you?** A finding, referee comment, methods issue, or writing block that was not on the map at the start.
   4. **What worked?** A practice, habit, or decision worth keeping; wins count.
   5. **The one systematizable lesson?** A rule for next time, concrete enough to become a skill, a checklist, or a memory entry.
4. **Save** to `.mstack/retro.md`.
5. **Promote.** If question 5 generalizes across papers, suggest `/mstack:learn` and the user's global memory (`~/.claude/CLAUDE.md`): `.mstack/learnings.jsonl` is paper-local, and the plugin's own docs are replaced on every update.

## Outputs

- `.mstack/retro.md`.
- Summary block: timeline + the one lesson + suggested follow-up.

## Anti-patterns

- **Generic lessons.** "Communicate more with coauthors" is not one; "30-minute check-in every Friday with C" is.
- **No timeline.** Without it the retro is vibes.
- **No wins.** A catalog of failures hides what to keep.

## Next

`/mstack:learn` for the lesson; `/mstack:archive` if the package is not yet built.
