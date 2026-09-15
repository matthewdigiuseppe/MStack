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
2. **Git clone:** run `bash "${CLAUDE_PLUGIN_ROOT}/bin/mstack-upgrade"`, which pulls `--ff-only`, lists the changed skills and references, and re-runs `setup` for permissions and PATH. Summarize previous version → new version and what changed.
3. **Marketplace install** (no `.git`; the plugin cache is a managed copy, not a repo): do not `git pull`; it cannot work there.
4. **Either way, the files on disk are not the loaded skills.** Tell the user to run `/plugin marketplace update mstack` and then restart Claude Code, which is what reloads them. A pull alone changes nothing in the running session.

## Outputs

- Summary: install mode, previous → new version (from `.claude-plugin/plugin.json`), the changed skills and references, and the reload-and-restart step.

## Anti-patterns

- **Upgrading mid-paper unannounced.** If a paper folder is in active use, surface the changeset first so the user can opt in.
- **`git pull` in the plugin cache.** A marketplace install is not a checkout; only `/plugin marketplace update` works there.
- **Reporting an upgrade as done after a pull.** Until the plugin is updated and Claude Code restarted, the session is still running the old skills.
