---
name: mstack-init
description: Scaffolds a new MStack paper folder (paper/, data/, code/, output/, .mstack/ memory) from the plugin template, LaTeX or Quarto. Use when the user wants to start a new paper, project, or study — e.g. "set up a new paper on X" — or asks to run mstack-init.
argument-hint: "<short-name> [--quarto]"
allowed-tools:
  - Bash
  - Read
  - Write
  - Edit
  - Glob
---

# /mstack:mstack-init

**Stage:** setup
**Voice:** scaffolder

## When to invoke

Starting a new paper. Every other MStack skill assumes the folder layout this skill creates; run it once per paper, in the directory where the paper folder should live.

## Argument

`$ARGUMENTS` — a short slug for the paper (e.g. `tariffs-aid`), optionally followed by `--quarto` for a Quarto main file instead of LaTeX. If no slug is given, ask for one (lowercase, hyphens, no spaces).

## Procedure

1. **Refuse to nest.** If the current directory (or an ancestor) already contains `.mstack/`, stop — a paper folder inside a paper folder breaks every path convention. Tell the user to `cd` out first.

2. **Run the bundled script.** The plugin root is available as `${CLAUDE_PLUGIN_ROOT}`:

   ```bash
   bash "${CLAUDE_PLUGIN_ROOT}/bin/mstack-init" <short-name> [--quarto]
   ```

3. **Fallback** (script missing or no bash): replicate it manually —
   - Copy `${CLAUDE_PLUGIN_ROOT}/templates/paper-folder` to `./<short-name>` (preserve hidden files).
   - Stamp `short_name: "<short-name>"` into `.mstack/config.yaml`.
   - If `--quarto`: replace `paper/main.tex` with a `main.qmd` that `{{< include >}}`s the section files as `.qmd`, and set `format: "quarto"` in config.

4. **Verify** the tree exists (`.mstack/config.yaml`, `paper/`, `data/raw/`, `code/`, `output/`).

5. **Hand off.** Tell the user to fill in `.mstack/config.yaml` (title, authors, target journals, `voice.writing_style` if they have a style skill installed), then start with `/mstack:research-question` or `/mstack:idea-shotgun`.

## Outputs

- `./<short-name>/` — the full paper scaffold.
- Summary block: created path, format (latex/quarto), next steps.

## Anti-patterns to refuse

- **Scaffolding over an existing folder.** If `./<short-name>` exists, stop; never merge into it.
- **Skipping config.** A scaffold with an empty config still works, but remind the user once — several skills read `target_journals` and `voice.*`.

## When to call other skills

- After: `/mstack:research-question` (interrogate the idea) or `/mstack:idea-shotgun` (generate angles).
- Anytime later: `/mstack:paper-status` to see where the project stands.
