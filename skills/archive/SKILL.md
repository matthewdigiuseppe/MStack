---
name: archive
description: Assembles the replication package to the Data and Code Availability Standard — inventory with checksums, licenses and data citations, renv lockfile, a replication README from the bundled template with an exhibit-to-script map, and a clean-room rebuild that regenerates every table and figure from raw data — and stages the OSF/Dataverse upload. Use at acceptance, whenever the user asks for a replication or reproducibility package, or mentions a Dataverse/OSF deposit or the journal's data policy.
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

At acceptance, before the production deadline. The goal is not the journal's data policy; it is that in two years anyone can rebuild every table and figure from raw data. The README follows the Data and Code Availability Standard (Vilhuber et al.) that the AJPS verification process and the AEA data editor apply, so a verifier finds what they expect where they expect it.

## Procedure

1. **Load** `.mstack/config.yaml` (title, the actual journal and its replication policy), `paper/`, `data/`, `code/`, `output/`, `prereg/`, `data/raw/PROVENANCE.md`.
2. **Inventory** to `replication-manifest.txt`, with a SHA-256 checksum per file: raw files with sources, vintages, licenses; crosswalks; clean data; code in run order; outputs (tables, figures, model objects); the accepted manuscript; preregistration and any addenda; `.mstack/llm-usage.jsonl` plus every `prompt_user_ref` / `code_ref` file it names (GUIDE-LLM artifacts), if the ledger exists.
3. **Licenses and citations.** Open or public-domain raw files ship; restricted ones (commercial, IRB, DUA) become a stub + re-acquire script, with the restriction, the access procedure, and the exhibits that need them documented in the README. Every source has a data citation (from `PROVENANCE.md` and `paper/refs.bib`). Tag each file in the manifest.
4. **Pin dependencies.** R: `sessionInfo()` and `renv::snapshot()` → `renv.lock` plus `renv/activate.R` so the package self-restores. System dependencies (LaTeX distribution, JAGS, Stan, GDAL) and Quarto / LaTeX versions listed. For long-lived packages, note a container recipe (a `rocker` image pinned to the R version) as optional insurance.
5. **Write the replication README** from `${CLAUDE_PLUGIN_ROOT}/skills/archive/assets/replication-README-template.md` into `README.md`, filling every section: overview with runtime and machine; data availability and provenance with the access certification; the data-sources table; computational requirements; the code table; replicator instructions that run **every** numbered script, not a hardcoded four (`/mstack:codebook`, `/mstack:power-analysis`, and `/mstack:robustness` add 00/05/06-series scripts whose outputs also ship):

   ```r
   renv::restore()
   scripts <- sort(list.files("code", pattern = "^[0-9].*\\.R$", full.names = TRUE))
   scripts <- scripts[!grepl("00-fetch", scripts)]  # raw data ships; fetch scripts hit the network
   for (f in scripts) source(f)
   ```

   the exhibits table mapping every table and figure in the paper and appendix to its script and output file; deviations from the published paper (a figure hand-edited in Illustrator, journal typesetting); data and software citations. A controller script `code/00-run-all.R` containing the loop above is worth adding.
6. **Clean-room rebuild.** Copy the project to a temporary directory; `renv::restore()`; run the loop; diff the rebuilt `output/tables/` and `output/figures/` against the originals (checksums, or a visual diff for figures); check every exhibit in the exhibits table was regenerated. Fix or document every divergence; **refuse to mark the package ready while any divergence is unexplained or any exhibit lacks a producing script.**
7. **Stage the upload:** repository (the journal's designated Dataverse if it has one; otherwise OSF; institutional as a mirror); build `submission/replication-<short_name>.zip` excluding `.git/`, `renv/library/` (rebuilt from `renv.lock`), and restricted raw files (stubs instead); print the upload checklist including the metadata the repository asks for (title, authors, related publication DOI, keywords, license).
8. **Config:** `paper.status: "archived"`; add the DOI / OSF URL once the user has it.

## Outputs

- `replication-manifest.txt` (with checksums), the replication `README.md`, `renv.lock` (+ `renv/activate.R`), optional `code/00-run-all.R`, `submission/replication-<short_name>.zip`.
- Summary block: file counts, restricted-data flags, divergences, exhibits without a script (should be none), upload destination, next manual step.

## Anti-patterns

- **Skipping the clean-room rebuild.** Without it this is not a replication package.
- **Bundling restricted data.** Stubs + re-acquire scripts; liability and IRB compliance live here.
- **"Available upon request."** Not a package, whatever the journal allows.
- **An exhibit with no script.** Every table and figure maps to code.
- **Unflagged hand-edited figures.** Document post-processing so the unedited version can be rebuilt.

## Next

`/mstack:retro` before the lessons fade; `/mstack:learn` for cross-paper conventions (global memory, not the per-paper `learnings.jsonl`).
