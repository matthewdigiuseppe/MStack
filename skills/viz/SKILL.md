---
name: viz
description: Publication-quality ggplot figures — one claim per figure, claim-stating titles, colorblind-safe palette, PDF+PNG+underlying CSV — via a bundled theme. Use when the user asks for figures, plots, coefficient or marginal-effects charts, or slide-ready graphics from results.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Glob
---

# /mstack:viz

**Stage:** analyze · **Voice:** figure-designer

After `/mstack:analyze` and `/mstack:robustness`, before `/mstack:draft-section results`: figures lock the visual argument, then the prose describes them.

## Procedure

1. **Load** `output/models/` and `data/clean/analytic.rds`. If `target_journals` is set in `.mstack/config.yaml`, match that journal's figure conventions (column width, color policy); ask the user for the artwork specs rather than guessing.
2. **Decide the figure set** (typically 1–3). Each figure is a claim: coefficient plot ("here are the estimated effects with CIs"); marginal effects / predicted probabilities ("what the model implies at substantively interesting values"); heterogeneity ("the effect varies across S as theory predicts"); specification curve ("robust to reasonable design choices"); map ("spatial / contextual variation is X"); density ("here is the relevant variation in the data"). Keep the figures that carry the headline; skip decoration.
3. **Write `code/03-figures.R`** (R conventions: `r-coding-skills` if installed, else `${CLAUDE_PLUGIN_ROOT}/references/r-conventions.md`). Copy `${CLAUDE_PLUGIN_ROOT}/skills/viz/assets/theme_mstack.R` to `code/theme_mstack.R` once per paper (so the replication package is self-contained) and `source()` it for `theme_mstack()`, Okabe–Ito scales, and `save_figure()` (PDF + PNG + CSV in one call). Conventions: one ggplot object per figure named `fig_<n>_<descriptor>`; **the title states the claim** ("Trade exposure raises protectionist vote share", not "Effect of trade on voting"); subtitle / caption carries the method; colorblind-safe palette (Okabe–Ito or `viridisLite::viridis()`); no chart-junk (shadows, 3D, gradients, excess gridlines); one consistent theme; explicit `width` / `height` / `units` on every save; `output/figures/<name>.pdf` (vector, paper), `.png` (raster, slides), `<name>-data.csv` (rebuildable from CSV alone).
4. **Run** `Rscript code/03-figures.R` and capture output.
5. **Check:** every figure renders; axis labels are human-readable, not variable names; legends present where needed and absent where redundant; sensible aspect ratio.

## Outputs

- `code/03-figures.R`, `code/theme_mstack.R`.
- `output/figures/<name>.pdf`, `.png`, `-data.csv` per figure.
- Summary block: figure count and the headline claim each carries.

## Anti-patterns

- **Default ggplot.** Nothing ships with `theme_grey()`.
- **Variables as titles.** Titles state claims.
- **No CSV.** A figure that cannot be rebuilt from a CSV is brittle.
- **Stars on coefficient plots.** Show CIs; let the reader decide.
- **More than 5 colors.** Use a panel.

## Next

`/mstack:draft-section results` references figures by their claim titles.
