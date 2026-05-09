---
name: mstack-upgrade
description: Pulls the latest MStack from GitHub and re-runs setup. Wraps the bin/mstack-upgrade shell script.
user-invocable: true
allowed-tools:
  - Bash
---

# /mstack:mstack-upgrade

**Stage:** power
**Voice:** maintenance

## Procedure

1. Run `mstack-upgrade` (the shell script at `bin/mstack-upgrade` in the MStack checkout) via Bash.
2. Capture stdout/stderr.
3. Summarize what changed: skills added, skills removed, version delta.

## Outputs

- Summary block: previous version → new version, list of new/changed skills, instruction to restart Claude Code if changes affect skill loading.

## Anti-patterns to refuse

- **Upgrading mid-paper without warning.** If a paper folder is in active use, surface the changeset *before* the upgrade so the user can opt in.
