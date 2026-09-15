---
name: archive
description: Assembles the replication package — inventory, licenses, renv lockfile, replication README, clean-room rebuild of every table and figure from raw data — and stages the OSF/Dataverse upload. Use at acceptance, whenever the user asks for a replication or reproducibility package, or mentions a Dataverse/OSF deposit or the journal's data policy.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# /mstack:archive

**Stage:** reflect (at acceptance) · **Voice:** replicator

At acceptance, before the production deadline. The goal is not the journal's data policy; it is that in two years anyone can rebuild every table and figure from raw data.

## Procedure

1. **Load** `.mstack/config.yaml` (title, the actual journal), `paper/`, `data/`, `code/`, `output/`, `prereg/`.
2. **Inventory** to `replication-manifest.txt`: raw files with sources, vintages, licenses; clean data; code in run order; outputs (tables, figures, model objects); the accepted manuscript; preregistration; `.mstack/llm-usage.jsonl` plus every `prompt_user_ref` / `code_ref` file it names (GUIDE-LLM artifacts), if the ledger exists.
3. **Licenses.** Open or public-domain raw files ship; restricted ones (commercial, IRB) become a stub + re-acquire script, with the restriction documented in the README. Tag each file in the manifest.
4. **Pin dependencies.** R: `sessionInfo()` and, preferably, `renv::snapshot()` → `renv.lock` plus `renv/activate.R` so the package self-restores. System dependencies (LaTeX distribution, JAGS, Stan, GDAL) and Quarto / LaTeX versions listed in the README.
5. **Extend `README.md`** into the replication README: one-paragraph summary + final citation; layout; reproduction steps that run **every** numbered script, not a hardcoded four (`/mstack:codebook`, `/mstack:power-analysis`, and `/mstack:robustness` add 00/05/06-series scripts whose outputs also ship):

   ```r
   renv::restore()
   scripts <- sort(list.files("code", pattern = "^[0-9].*\\.R$", full.names = TRUE))
   scripts <- scripts[!grepl("00-fetch", scripts)]  # raw data ships; fetch scripts hit the network
   for (f in scripts) source(f)
   ```

   plus a script-to-output map indexed by `output/` filename; data-source documentation per raw file; known divergences from the published paper (e.g. a figure hand-edited in Illustrator); license (CC-BY for code unless the user says otherwise; data licenses inherit from sources); contact and a DOI placeholder.
6. **Clean-room rebuild.** Copy the project to a temporary directory; `renv::restore()`; run the loop above; diff the rebuilt `output/tables/` and `output/figures/` against the originals (checksums, or visual diff for figures). Fix or document every divergence; **refuse to mark the package ready while any divergence is unexplained.**
7. **Stage the upload:** repository (OSF unless the journal specifies; Dataverse; institutional); build `submission/replication-<short_name>.zip` excluding `.git/`, `renv/library/` (rebuilt from `renv.lock`), and restricted raw files (stubs instead); print the upload checklist.
8. **Config:** `paper.status: "archived"`; add the DOI / OSF URL once the user has it.

## Outputs

- `replication-manifest.txt`, extended `README.md`, `renv.lock` (+ `renv/activate.R`), `submission/replication-<short_name>.zip`.
- Summary block: file counts, restricted-data flags, divergences, upload destination, next manual step.

## Anti-patterns

- **Skipping the clean-room rebuild.** Without it this is not a replication package.
- **Bundling restricted data.** Stubs + re-acquire scripts; liability and IRB compliance live here.
- **"Available upon request."** Not a package, whatever the journal allows.
- **Unflagged hand-edited figures.** Document post-processing so the unedited version can be rebuilt.

## Next

`/mstack:retro` before the lessons fade; `/mstack:learn` for cross-paper conventions (global memory, not the per-paper `learnings.jsonl`).
