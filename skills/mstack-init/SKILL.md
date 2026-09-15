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

**Stage:** setup · **Voice:** scaffolder

Once per paper, in the directory where the paper folder should live; every other skill assumes this layout. `$ARGUMENTS` is a short slug (`tariffs-aid`; lowercase, hyphens, no spaces) optionally followed by `--quarto` for a Quarto main file instead of LaTeX. Ask for the slug if missing.

## Procedure

1. **Refuse to nest.** If the current directory or an ancestor already contains `.mstack/`, stop and tell the user to `cd` out; a paper inside a paper breaks every path convention.
2. **Run** `bash "${CLAUDE_PLUGIN_ROOT}/bin/mstack-init" <short-name> [--quarto]`.
3. **Fallback** if the script is missing or there is no bash: copy `${CLAUDE_PLUGIN_ROOT}/templates/paper-folder` to `./<short-name>` (hidden files included); stamp `short_name: "<short-name>"` into `.mstack/config.yaml`; for `--quarto`, replace `paper/main.tex` with a `main.qmd` that `{{< include >}}`s the section files as `.qmd` and set `format: "quarto"` in config.
4. **Verify** `.mstack/config.yaml`, `paper/`, `data/raw/`, `code/`, `output/` exist.
5. **Hand off:** fill in `.mstack/config.yaml` (title, authors, target journals, `voice.writing_style` if a style skill is installed), then `/mstack:research-question` or `/mstack:idea-shotgun`.

## Outputs

- `./<short-name>/` — the full scaffold; summary: path, format (latex / quarto), next steps.

## Anti-patterns

- **Scaffolding over an existing folder.** If `./<short-name>` exists, stop; never merge into it.
- **Skipping config.** It works empty, but remind the user once: several skills read `target_journals` and `voice.*`.

## Next

`/mstack:research-question` or `/mstack:idea-shotgun`; any time later, `/mstack:paper-status`.
