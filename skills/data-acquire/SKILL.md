---
name: data-acquire
description: Downloads and documents every raw data source with vintage, license, SHA-256 manifest, and a PROVENANCE.md log; restricted data gets a stub plus re-acquire script. Use at the start of empirical work, whenever the user pulls a dataset (V-Dem, WDI, COW, survey exports), or before any cleaning.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - WebFetch
  - Glob
---

# /mstack:data-acquire

**Stage:** build · **Voice:** data-engineer

Start of empirical work, before `/mstack:data-clean`.

## Procedure

1. **List the sources.** For each: name + canonical URL or DOI; vintage / version (V-Dem v14, WDI 2024); license (open / restricted / proprietary); format (CSV, Stata, SPSS, API, scrape); granularity (country-year, individual, dyad-year).
2. **Acquire** to `data/raw/<source-shortname>/`. Public: download via curl / wget / API with the version in the filename. DOI'd: from the archive (Dataverse, OSF), keeping the DOI. Scraped: a fetch script at `code/00-fetch-<source>.R` plus the output and fetch date. Restricted: **not** in the repo; a stub `data/raw/<source>/README.md` describing how to acquire it.
3. **Hash** each source: `sha256sum data/raw/<source>/* > data/raw/<source>/SHA256SUMS` (`shasum -a 256` on macOS).
4. **Write `data/raw/PROVENANCE.md`**, one entry per source:

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
   - Notes: <e.g. "source imputes missing 2023 values">
   ```

5. **Sanity check** each source: row and column counts match what the source documents; note column-name aliases (`country` vs. `cname` vs. `country_text_id`).
6. **Config.** Append to `decisions:` in `.mstack/config.yaml` (`- "<date>: acquired raw data from [sources]"`) and set `paper.status: "building"`.

## Outputs

- `data/raw/<source>/...` — untouched after this skill runs, with `SHA256SUMS` per source.
- `data/raw/PROVENANCE.md` — the log, indexed by source.
- `code/00-fetch-<source>.R` for any non-static source.
- Summary block: sources acquired, restrictions to flag, next step.

## Anti-patterns

- **Editing `data/raw/` afterwards.** Raw is read-only and the guard hook denies edits to existing raw files; any fix is a recode in `code/01-clean.R`.
- **Undocumented sources.** Every file in `data/raw/` has a PROVENANCE entry.
- **Bundling restricted data.** Stub + acquire script only.

## Next

`/mstack:data-clean`.
