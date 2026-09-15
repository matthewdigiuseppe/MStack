---
name: data-acquire
description: Downloads and documents every raw data source — vintage, identifier scheme, sentinel codes, license, data citation, SHA-256 manifest — in a PROVENANCE.md log, with stubs plus re-acquire scripts for restricted data and versioned crosswalks for merging. Use at the start of empirical work, whenever the user pulls a dataset (V-Dem, Polity, COW, WDI, Comtrade, ESS, survey exports), or before any cleaning — /mstack:data-clean refuses to run without it.
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

Start of empirical work, before `/mstack:data-clean`. What is recorded here is what makes the merge in `01-clean.R` and the replication package possible; the pitfalls of the common datasets are in `${CLAUDE_PLUGIN_ROOT}/references/polisci-data-sources.md`, which this skill reads before touching a source.

## Procedure

1. **Read the data-sources reference** and list the sources the project needs. For each: name; canonical URL or DOI; vintage or version (V-Dem v14, Polity5 2018 release, WDI download date, Comtrade extraction date and HS revision); license and any data-use agreement; format (CSV, Stata, API, scrape); unit and granularity (country-year, dyad-year, region-year, respondent); the **identifier scheme** it uses (COW, Gleditsch–Ward, ISO3, NUTS version, party ids); the **sentinel or missing codes** documented in its codebook; known revisions and breaks.
2. **Acquire** to `data/raw/<source-shortname>/`. Public: download via curl / wget / API with the version in the filename, and record the exact query, filters, and extraction date for API pulls. DOI'd: from the archive (Dataverse, OSF, ICPSR), keeping the DOI. Scraped: a fetch script at `code/00-fetch-<source>.R` plus the output and fetch date. Restricted or licensed: **not** in the repo; a stub `data/raw/<source>/README.md` describing how to obtain it, the DUA terms, and which outputs need it.
3. **Crosswalks.** Put every identifier crosswalk the merge will need (country codes, NUTS versions, party ids) in `data/raw/crosswalks/`, versioned and cited (the `countrycode` package's tables, Eurostat NUTS correspondence files, ParlGov links).
4. **Hash** each source: `sha256sum data/raw/<source>/* > data/raw/<source>/SHA256SUMS` (`shasum -a 256` on macOS).
5. **Write `data/raw/PROVENANCE.md`**, one entry per source:

   ```
   ### <source-shortname>
   - URL / DOI: <link>
   - Version / vintage: <version + release date; extraction date and query for APIs>
   - Acquired: <YYYY-MM-DD by <user>>
   - License / DUA: <license; restrictions>
   - Format: <format>
   - Unit / granularity: <unit-of-analysis>
   - Identifier scheme: <COW | GW | ISO3 | NUTS-2016 | ...>
   - Sentinel / missing codes: <e.g. -66/-77/-88; -9; 999; ".."; zero = not reported>
   - Known revisions or breaks: <e.g. GDP revised in v10; coverage starts 1997 for Africa>
   - Files: <list of files in data/raw/<source>/>
   - SHA256 manifest: data/raw/<source>/SHA256SUMS
   - Data citation: <as the provider requests; also staged in paper/refs.bib>
   - Notes: <e.g. "source imputes missing 2023 values">
   ```

6. **Cite the data.** Append a BibTeX entry per source to `paper/refs.bib` in the provider's requested form (dataset DOIs, version, year); journals increasingly require data citations, and the replication README reuses them.
7. **Sanity check** each source: row and column counts match what the source documents; column-name aliases noted (`country` vs. `cname` vs. `country_text_id`); the sentinel codes actually appear where the codebook says; a quick time series of a key variable by unit looks like the provider's own figures.
8. **Config.** Append to `decisions:` in `.mstack/config.yaml` (`- "<date>: acquired raw data from [sources]"`) and set `paper.status: "building"`.

## Outputs

- `data/raw/<source>/...` — untouched after this skill runs, with `SHA256SUMS` per source.
- `data/raw/PROVENANCE.md` — the log, indexed by source.
- `data/raw/crosswalks/` — identifier crosswalks.
- `code/00-fetch-<source>.R` for any non-static source; data citations in `paper/refs.bib`.
- Summary block: sources acquired, identifier schemes in play, restrictions to flag, next step.

## Anti-patterns

- **Editing `data/raw/` afterwards.** Raw is read-only and the guard hook denies edits to existing raw files; any fix is a recode in `code/01-clean.R`.
- **Undocumented sources.** Every file in `data/raw/` has a PROVENANCE entry.
- **Bundling restricted data.** Stub + acquire script only.
- **Vintage unrecorded.** A rerun on a revised release will not reproduce the tables.

## Next

`/mstack:data-clean`.
