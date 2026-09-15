---
name: mstack-upgrade
description: Updates MStack — git pull plus setup for clone installs, or points marketplace installs at /plugin marketplace update. User-invoked only.
disable-model-invocation: true
allowed-tools:
  - Bash
  - Read
---

# /mstack:mstack-upgrade

**Stage:** power · **Voice:** maintenance

## Procedure

1. **Detect the install:** does `${CLAUDE_PLUGIN_ROOT}/.git` exist?
2. **Git clone** (installed via `./setup`): run `bash "${CLAUDE_PLUGIN_ROOT}/bin/mstack-upgrade"`, which pulls `--ff-only` and re-runs setup. Summarize previous version → new version and skills added / removed / changed.
3. **Marketplace install** (no `.git`; the plugin cache is a managed copy, not a repo): do not `git pull`. Tell the user to run `/plugin marketplace update mstack` and restart Claude Code so reloaded skills take effect.

## Outputs

- Summary: install mode, previous → new version (from `.claude-plugin/plugin.json`), restart reminder if skills changed.

## Anti-patterns

- **Upgrading mid-paper unannounced.** If a paper folder is in active use, surface the changeset first so the user can opt in.
- **`git pull` in the plugin cache.** A marketplace install is not a checkout; only `/plugin marketplace update` works there.
