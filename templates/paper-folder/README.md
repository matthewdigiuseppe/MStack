# {PAPER TITLE}

Scaffolded by [MStack](https://github.com/matthewdigiuseppe/MStack).

## Layout

```
.mstack/         # MStack config + learnings + caches (do not delete)
paper/           # manuscript: main.tex + sections/
lit/pdf/         # source PDFs of the literature (read-only after ingest)
lit/md/          # those PDFs as Markdown, via /mstack:pdf-ingest
lit/index.md     # corpus triage table — read this before opening any paper
data/raw/        # untouched source data
data/clean/      # analytic dataset(s) produced by code/01-clean.R
data/codebook.md # variable-level docs
code/            # numbered R scripts (00-* setup, 01-clean → 06-robustness)
output/figures/  # publication-quality figures
output/tables/   # regression tables, .tex
submission/      # cover letter + response-to-reviewers
prereg/          # preregistration documents
```

## Reproducing

```r
# From the project root in R — runs every numbered script in order
# (00-fetch-* scripts are skipped: raw data is already in data/raw/):
scripts <- sort(list.files("code", pattern = "^[0-9].*\\.R$", full.names = TRUE))
for (f in scripts[!grepl("00-fetch", scripts)]) source(f)
```

By submission time, this README doubles as the replication-package README.
`/mstack:archive` extends it with a dependency manifest and clean-room rebuild instructions.
