# Replication package: "<paper title>"

<Authors> · Contact: <email> · Package version: <YYYY-MM-DD> · Paper DOI: <> · Package DOI/URL: <>

## Overview

<One paragraph: what the paper does, and what this package reproduces (every table and figure in the paper and appendix from the raw data in `data/raw/`, or from the stubs described below). Expected runtime and the machine it was last run on.>

## Data availability and provenance

<For each source: name, citation, URL or DOI, vintage or access date, license, and whether the file is included. For restricted sources: how to obtain them, and which exhibits cannot be reproduced without them.>

The authors certify that they have legitimate access to and permission to use all data in this package, and that the included data may be redistributed under the licenses listed.

| File in `data/raw/` | Source and citation | Vintage / accessed | License | Included | Notes |
|---|---|---|---|---|---|
| | | | | | |

## Computational requirements

- Software: R <version>; packages pinned in `renv.lock` (`renv::restore()` installs them); system dependencies: <LaTeX distribution, JAGS, Stan, GDAL, none>.
- Hardware and time: <cores, memory>; wall time per script in the table below.
- Randomness: seeds set in <scripts>; results are deterministic given the lockfile.

## Code

| Script | Purpose | Inputs | Outputs | Runtime |
|---|---|---|---|---|
| `code/01-clean.R` | raw → analytic dataset | `data/raw/...` | `data/clean/analytic.rds`, `data/clean/clean-log.md` | |
| `code/02-analyze.R` | primary and secondary models | `data/clean/analytic.rds` | `output/models/*.rds`, `output/analyze-log.md` | |
| `code/03-figures.R` | figures | `output/models/*.rds` | `output/figures/*` | |
| `code/04-tables.R` | tables | `output/models/*.rds` | `output/tables/*.tex` | |
| `code/05-robustness.R`, `code/06-robustness-table-and-curve.R` | robustness | | `output/models/robustness.rds`, table, curve | |
| `code/00-*.R` | power, codebook, fetch scripts (fetch scripts hit the network and are skipped in the rebuild) | | | |

## Instructions for replicators

1. Clone or unzip the package; open R at the package root.
2. `renv::restore()`.
3. Run every numbered script in order (fetch scripts excluded):
   ```r
   scripts <- sort(list.files("code", pattern = "^[0-9].*\\.R$", full.names = TRUE))
   for (f in scripts[!grepl("00-fetch", scripts)]) source(f)
   ```
4. Compare `output/tables/` and `output/figures/` with the checksums in `replication-manifest.txt`.

## Exhibits

| Exhibit in paper | Script | Output file | Notes |
|---|---|---|---|
| Table 1 | `code/04-tables.R` | `output/tables/table-1-descriptives.tex` | |
| Table 2 | `code/04-tables.R` | `output/tables/table-2-primary.tex` | |
| Figure 1 | `code/03-figures.R` | `output/figures/fig-1-<name>.pdf` | |

## Deviations from the published paper

<Any exhibit that differs from the published version and why: hand-edited figure, journal typesetting, a data revision. If none, say so.>

## References

<Data citations and software citations (R, key packages) in the paper's reference style.>
