---
name: viz
description: Publication-quality ggplot figures matched to the claim each makes — coefficient plots, marginal effects with moderator support, event studies and RD plots that show the design's credibility, specification curves and sensitivity plots, small multiples of the variation the design uses — with claim-stating titles, a colorblind-safe palette, and PDF+PNG+underlying CSV via a bundled theme. Use when the user asks for figures, plots, coefficient or marginal-effects charts, event-study or RD plots, or slide-ready graphics from results.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Glob
---

# /mstack:viz

**Stage:** analyze · **Voice:** figure-designer

After `/mstack:analyze` and `/mstack:robustness`, before `/mstack:draft-section results`: figures lock the visual argument, then the prose describes them. A paper's figures should let a reader who skips the tables see the effect, believe the design, and judge the robustness.

## Procedure

1. **Load** `output/models/`, `output/models/robustness.rds`, `data/clean/analytic.rds`, `.mstack/config.yaml` (`design.type`, `target_journals`), and `${CLAUDE_PLUGIN_ROOT}/references/figure-conventions.md`. If a target journal is set, match its figure conventions (column width, color policy); ask the user for the artwork specs rather than guessing.
2. **Decide the figure set** from the figure-by-claim table in the reference. Every paper gets at least: one figure showing the variation the design uses (treatment by unit over time, or the distribution across groups), one figure showing the design's credibility (event study with the pre-period, RD plot with binned means and the bandwidth, balance plot, first stage), the effect figure (coefficient plot, or predicted values at substantively chosen values with the moderator's support shown), and the robustness figure (specification curve; sensitivity contour or breakdown). Keep the figures that carry the headline; skip decoration.
3. **Write `code/03-figures.R`** (R conventions: `r-coding-skills` if installed, else `${CLAUDE_PLUGIN_ROOT}/references/r-conventions.md`). Copy `${CLAUDE_PLUGIN_ROOT}/skills/viz/assets/theme_mstack.R` to `code/theme_mstack.R` once per paper (so the replication package is self-contained) and `source()` it for `theme_mstack()`, Okabe–Ito scales, and `save_figure()` (PDF + PNG + CSV in one call). Conventions: one ggplot object per figure named `fig_<n>_<descriptor>`, built from the saved model objects with `marginaleffects` for predictions and intervals; **the title states the claim** ("Trade exposure raises protectionist vote share", not "Effect of trade on voting"); subtitle carries the estimand and sample; caption carries the model, standard errors, and N; the same color means the same thing in every figure; at most five series; direct labels where possible; a zero line where zero means no effect; axes in substantive units; explicit `width` / `height` / `units` on every save; `output/figures/<name>.pdf` (vector, paper), `.png` (raster, slides), `<name>-data.csv` (rebuildable from CSV alone).
4. **Run** `Rscript code/03-figures.R` and capture output.
5. **Check** against the "what referees fault" list in the reference: every figure renders; intervals come from the same standard-error choice as the tables; event studies show the reference period and the full pre-period; marginal effects stay inside the moderator's support; axis labels are human-readable; legends present where needed and absent where redundant; sensible aspect ratio and print size.

## Outputs

- `code/03-figures.R`, `code/theme_mstack.R`.
- `output/figures/<name>.pdf`, `.png`, `-data.csv` per figure.
- Summary block: figure count, the claim each carries, and which figures show variation, credibility, effect, and robustness.

## Anti-patterns

- **Default ggplot.** Nothing ships with `theme_grey()`.
- **Variables as titles.** Titles state claims.
- **An effect figure with no credibility figure.** Show the design, not only the estimate.
- **No CSV.** A figure that cannot be rebuilt from a CSV is brittle.
- **Stars on coefficient plots.** Show intervals; let the reader decide.
- **Dual axes, 3D, pies, gradients, more than five colors.**

## Next

`/mstack:draft-section results` references figures by their claim titles.
