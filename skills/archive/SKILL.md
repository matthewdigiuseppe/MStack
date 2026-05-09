---
name: archive
description: Assembles a replication package — data, code, README, codebook, dependency manifest — and preps OSF / Dataverse upload. Run at acceptance. Verifies via clean-room rebuild that every table and figure regenerates from raw data.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# /mstack:archive

**Stage:** reflect (at acceptance)
**Voice:** replicator

## When to invoke

The paper is accepted. Before the journal sets the production deadline you forgot about, lock the replication package. The point is not to satisfy the journal's data policy — it's to ensure that two years from now you (or anyone else) can rebuild every table and figure from raw data.

## Procedure

1. **Load context.**
   - `.mstack/config.yaml` for paper title, target journal (now the actual journal).
   - `paper/`, `data/`, `code/`, `output/`.
   - `prereg/` if applicable.

2. **Inventory.** Walk the project and list:
   - Raw data files in `data/raw/` with sources, vintages, licenses.
   - Cleaned data file(s) in `data/clean/`.
   - Code files in `code/`, ordered by run order.
   - Output files in `output/` (tables, figures, model objects).
   - Manuscript files (final accepted version).
   - Preregistration documents.
   Save the inventory to `replication-manifest.txt`.

3. **Check licenses.** For each raw data file:
   - Public-domain or open: include in the package.
   - Restricted (e.g., commercial, IRB-restricted): replace with a stub + script that re-acquires from source. Document the restriction in the README.
   Tag each file accordingly in `replication-manifest.txt`.

4. **Pin dependencies.**
   - R: capture `sessionInfo()` and (preferred) generate a `renv.lock` via `renv::snapshot()`. Add `renv/activate.R` so the package self-restores.
   - System dependencies: list in the README (e.g., LaTeX distribution, JAGS, Stan, GDAL).
   - Quarto/LaTeX versions if relevant.

5. **Extend `README.md`** into a replication README with:
   - One-paragraph paper summary + final citation.
   - Layout (the standard MStack tree).
   - Reproduction steps:
     ```r
     renv::restore()
     source("code/01-clean.R")
     source("code/02-analyze.R")
     source("code/03-figures.R")
     source("code/04-tables.R")
     ```
   - Mapping: which script produces which table / figure (a table indexed by `output/` filename).
   - Data source documentation (one entry per raw file).
   - Known divergences from the published paper (e.g., a figure that was hand-edited in Illustrator — flag the post-hoc edit).
   - License (CC-BY for code unless user specifies otherwise; data licenses inherit from sources).
   - Contact + DOI placeholder for the published paper.

6. **Clean-room rebuild test.**
   - Move the project to a temporary clean directory.
   - Run `renv::restore()` then the four `source()` calls in order.
   - Diff the rebuilt `output/tables/` and `output/figures/` against the originals (file-level checksum or visual diff for figures).
   - Any divergence: fix or document. **Refuse to mark the package "ready" if divergences are unexplained.**

7. **Stage the upload bundle.**
   - Decide repository: OSF, Dataverse, or institutional. (Default: OSF unless the journal specifies.)
   - Build the upload tarball at `submission/replication-<short_name>.zip` excluding `.git/`, `renv/library/` (rebuild via `renv.lock`), and any restricted raw files (substituted with stubs).
   - Print the upload checklist to the user.

8. **Update `.mstack/config.yaml`:** set `paper.status: "archived"` and add the DOI / OSF URL once the user provides it.

## Outputs

- `replication-manifest.txt` — inventory with sources and licenses.
- Extended `README.md` — replication documentation.
- `renv.lock` (and `renv/activate.R`) — pinned R dependencies.
- `submission/replication-<short_name>.zip` — upload bundle.
- A summary block to the user: file counts, restricted-data flags, divergences (if any), upload destination, next manual step.

## Anti-patterns to refuse

- **Skipping the clean-room rebuild.** A replication package that hasn't been clean-room-rebuilt is not a replication package.
- **Bundling restricted data.** Substitute with stubs + re-acquire scripts, document the restriction. Liability and IRB compliance live here.
- **"Available upon request."** This is not a replication package. If the journal allows it, fine; MStack does not.
- **Hand-edited figures with no flag.** If a figure was post-processed outside the code, document it explicitly so reviewers / replicators can rebuild the unedited version.

## When to call other skills

- Before: `/retro` to capture lessons before they fade.
- After: `/learn` to write any cross-paper conventions you discovered into your global memory (not the per-paper `learnings.jsonl`).
