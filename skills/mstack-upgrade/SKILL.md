---
name: mstack-upgrade
description: Updates MStack — git pull plus setup for clone installs, or points marketplace installs at /plugin marketplace update. User-invoked only.
disable-model-invocation: true
allowed-tools:
  - Bash
  - Read
---

# /mstack:mstack-upgrade

**Stage:** power
**Voice:** maintenance

## Procedure

1. **Detect the install mode.** Check whether `${CLAUDE_PLUGIN_ROOT}/.git` exists.

2. **Git-clone install** (power users who ran `./setup`): run
   `bash "${CLAUDE_PLUGIN_ROOT}/bin/mstack-upgrade"` — it pulls `--ff-only` and
   re-runs setup. Capture stdout/stderr and summarize: previous version → new
   version, skills added/removed/changed.

3. **Marketplace install** (no `.git` — the plugin lives in Claude Code's
   plugin cache, which is a managed copy, not a repo): do **not** attempt
   `git pull`; it cannot work there. Tell the user to run:

   ```
   /plugin marketplace update mstack
   ```

   and restart Claude Code afterward so re-loaded skills take effect.

## Outputs

- Summary block: install mode detected, previous version → new version (from
  `.claude-plugin/plugin.json`), and a restart reminder if skills changed.

## Anti-patterns to refuse

- **Upgrading mid-paper without warning.** If a paper folder is in active use, surface the changeset *before* the upgrade so the user can opt in.
- **`git pull` in the plugin cache.** A marketplace install is not a checkout; the only supported update path is `/plugin marketplace update`.
