# R conventions (MStack fallback)

Built-in fallback for the R conventions MStack skills apply. If the user has an
`r-coding-skills` skill installed, that skill wins wherever the two disagree —
this file exists so the pipeline behaves sensibly without it.

## Style

- Tidyverse style: `snake_case` names, 2-space indent, `<-` for assignment.
- Native pipe `|>`; one pipeline step per line; name intermediate objects when a
  pipeline exceeds ~6 steps.
- `library()` calls grouped at the top of the script, one per line, no
  `require()` and no inline `::` loading of attached packages.
- Paths via `here::here()` from the project root; never `setwd()`, never
  absolute paths.
- `set.seed()` before anything stochastic; the seed is part of the record.
- Comments explain *why*, not *what*. Every script opens with a header block:
  purpose, inputs, outputs, run order.

## Script structure

- Numbered scripts, single purpose each: `00-*` (fetch/power/codebook),
  `01-clean.R`, `02-analyze.R`, `03-figures.R`, `04-tables.R`,
  `05-robustness.R`, `06-robustness-table-and-curve.R`. Cleaning never models;
  modeling never cleans.
- Every join and drop is logged: `nrow()` before/after plus
  `stopifnot(nrow(df) == expected)`. Silent row loss is the classic
  irreproducibility bug.
- Save analytic data as `.rds` (plus a `.csv` mirror for portability); dump
  `sessionInfo()` to a text file alongside outputs.

## Modeling defaults

- OLS / fixed effects: `fixest::feols()`. State the FE dimensions and the
  clustering level explicitly; the cluster level must match the dependence
  structure, not habit.
- Marginal effects and predictions: `marginaleffects`.
- Tables: `modelsummary::modelsummary(output = "latex")` written to
  `output/tables/*.tex`; the manuscript `\input`s them. Report coefficients
  with 95% CIs; stars only when the journal demands them.

## Figures

- ggplot2 with `theme_minimal()` or the bundled `theme_mstack.R`
  (colorblind-safe Okabe–Ito palette).
- `ggsave()` with explicit `width`/`height`/`units`; save `.pdf` (paper) and
  `.png` (slides), and write the underlying data to a `-data.csv` next to the
  figure.
