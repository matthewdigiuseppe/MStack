---
name: data-acquire
description: Pulls and documents raw data sources with a provenance log. Writes to data/raw/ and produces data/raw/PROVENANCE.md. Use at the start of any empirical project. /data-clean refuses to run without this.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - WebFetch
  - Glob
---

# /mstack:data-acquire

**Stage:** build
**Voice:** data-engineer

## When to invoke

Start of empirical work. Before `/data-clean`.

## Procedure

1. **List the sources** the project needs. For each:
   - Name + URL or DOI of the canonical source.
   - Vintage / version (e.g., V-Dem v14, WDI 2024).
   - License (open / restricted / proprietary).
   - Format (CSV, Stata, SPSS, API, scrape).
   - Granularity (country-year, individual, dyad-year).

2. **Acquire each source** to `data/raw/<source-shortname>/`:
   - For public data: download via `curl` / `wget` / API, save with the version in the filename.
   - For DOI'd data: download from the archive (Dataverse, OSF), keep the DOI.
   - For scraped data: write a fetch script in `code/00-fetch-<source>.R` and save the output, plus the date of fetch.
   - For restricted data: do **not** put it in the repo. Save a stub README in `data/raw/<source>/README.md` describing how to acquire it.

3. **Hash each file** for integrity verification: `shasum -a 256 data/raw/<source>/* > data/raw/<source>/SHA256SUMS`.

4. **Write `data/raw/PROVENANCE.md`** with one entry per source:

   ```
   ### <source-shortname>
   - URL / DOI: <link>
   - Version / vintage: <version + date>
   - Acquired: <YYYY-MM-DD by <user>>
   - License: <license>
   - Format: <format>
   - Granularity: <unit-of-analysis>
   - Files: <list of files in data/raw/<source>/>
   - SHA256 manifest: data/raw/<source>/SHA256SUMS
   - Restrictions: <none | description>
   - Notes: <e.g., "imputed by source for missing 2023 values">
   ```

5. **Sanity check.** For each source:
   - Open the file; confirm row count and column count match what the source documents.
   - Note any column-name aliases the source uses (`country` vs. `cname` vs. `country_text_id`).

6. **Update `.mstack/config.yaml`** decisions log: `<date>: acquired raw data from [list of sources]`.

## Outputs

- `data/raw/<source>/...` — raw data, untouched after this skill runs.
- `data/raw/<source>/SHA256SUMS` — integrity manifest.
- `data/raw/PROVENANCE.md` — log indexed by source.
- `code/00-fetch-<source>.R` — fetch scripts for any non-static source.
- Summary block: count of sources acquired, restrictions to flag, suggested next step (`/data-clean`).

## Anti-patterns to refuse

- **Editing files in `data/raw/` after this skill.** Raw is read-only. Any fix is a recode in `code/01-clean.R`.
- **Undocumented sources.** Every file in `data/raw/` has a `PROVENANCE.md` entry.
- **Bundling restricted data.** Stub + acquire-script only.

## When to call other skills

- After: `/data-clean`.
