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

**Stage:** analyze
**Voice:** figure-designer (anchored to `r-coding-skills`)

## When to invoke

After `/mstack:analyze` and `/mstack:robustness` produce stable results. Before `/mstack:draft-section results`. Figures lock the visual argument; once stable, the prose can describe them.

## Procedure

1. **Load.** `output/models/`, `data/clean/analytic.rds`. If `target_journals` in `.mstack/config.yaml` is set, match that journal's figure conventions (column width, color policy) — ask the user for the artwork specs when unknown rather than guessing them.

2. **Decide the figure set.** A typical IPE / political science paper has 1–3 figures. Each is a claim:

   | Figure type | Claim it makes |
   |---|---|
   | Coefficient plot | "Here are the estimated effects with CIs." |
   | Marginal effects / predicted probability | "Here is what the model implies at substantively interesting values." |
   | Heterogeneity plot | "The effect varies across S as theory predicts." |
   | Specification curve | "Findings are robust across reasonable design choices." |
   | Map | "Spatial / contextual variation is X." |
   | Density / distribution | "Here is the relevant variation in the data." |

   Pick the figures that carry the headline. Skip figures that just decorate.

3. **Write `code/03-figures.R`.** First copy the bundled theme — `${CLAUDE_PLUGIN_ROOT}/skills/viz/assets/theme_mstack.R` → `code/theme_mstack.R`, once per paper, so the replication package is self-contained — and `source()` it: it provides `theme_mstack()`, Okabe–Ito color scales, and `save_figure()` (PDF + PNG + underlying CSV in one call). Conventions:
   - One ggplot object per figure, named `fig_<n>_<descriptor>`.
   - **Title states the claim**, not the variables (e.g., `"Trade exposure raises protectionist vote share"`, not `"Effect of trade on voting"`).
   - **Subtitle / caption** carries the methodological detail.
   - Colorblind-safe palette (`viridisLite::viridis()` or Okabe–Ito).
   - No chart-junk: no shadows, no 3D, no gradient fills, no excess gridlines.
   - Theme: `theme_minimal()` or a custom journal-style theme; consistent across figures.
   - Save each figure to **both** `output/figures/<name>.pdf` (vector, for the paper) and `output/figures/<name>.png` (raster, for slides / web). Use `ggsave(..., width = X, height = Y, units = "in")` with explicit dimensions; never `dev.off()` without dimensions.
   - Save underlying figure data to `output/figures/<name>-data.csv` so the figure is replicable from CSV alone.

4. **Run** `Rscript code/03-figures.R`. Capture stdout/stderr.

5. **Sanity check.**
   - Each figure renders.
   - Axis labels are human-readable (not variable names).
   - Legends are present where needed and absent where redundant.
   - Aspect ratio is sensible (no squished or stretched plots).

## Outputs

- `code/03-figures.R`.
- `output/figures/<name>.pdf`, `<name>.png`, `<name>-data.csv` per figure.
- Summary block: count of figures, the headline claim each carries.

## Anti-patterns to refuse

- **Default ggplot.** No figure ships with `theme_grey()`.
- **Variables as titles.** Titles state claims.
- **No CSV.** A figure that can't be rebuilt from a CSV is brittle.
- **Stars on coefficient plots.** Show CIs, let the reader decide.
- **More than 5 colors.** If you need a sixth, use a panel.

## When to call other skills

- Before: `/mstack:analyze`, `/mstack:robustness`.
- After: `/mstack:draft-section results` references the figures by their claim-titles.
