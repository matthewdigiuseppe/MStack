# {PAPER TITLE}

Scaffolded by [MStack](https://github.com/<you>/MStack).

## Layout

```
.mstack/         # MStack config + learnings + caches (do not delete)
paper/           # manuscript: main.tex + sections/
data/raw/        # untouched source data
data/clean/      # analytic dataset(s) produced by code/01-clean.R
data/codebook.md # variable-level docs
code/            # numbered R scripts (01-clean → 04-tables)
output/figures/  # publication-quality figures
output/tables/   # regression tables, .tex
submission/      # cover letter + response-to-reviewers
prereg/          # preregistration documents
```

## Reproducing

```r
# From the project root in R:
source("code/01-clean.R")
source("code/02-analyze.R")
source("code/03-figures.R")
source("code/04-tables.R")
```

By submission time, this README doubles as the replication-package README.
`/archive` extends it with a dependency manifest and clean-room rebuild instructions.
