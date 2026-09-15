# Figure conventions

Read by `/mstack:viz` when deciding the figure set and writing
`code/03-figures.R`, and by `/mstack:draft-section results` when describing
figures. The bundled `theme_mstack.R` implements the mechanics (palette,
theme, `save_figure()`); this file is about which figure makes which claim
and what a referee will fault.

## Figure by claim

| Claim | Figure | Construction rules |
|---|---|---|
| "The effect is this big" | Coefficient plot | Point estimate with 95% (and optionally 90%) intervals, horizontal, ordered by magnitude or by theory; one model per panel or clearly distinguished; standardized units or labeled; never stars (Kastellec & Leoni 2007) |
| "What the model implies at values that matter" | Predicted values or average marginal effects at substantively chosen values | Delta-method or simulated intervals (`marginaleffects`); the moderator's distribution shown as a rug or histogram so no one reads off support that does not exist |
| "The effect varies with S" | Marginal effect of X across S | Linear and binning estimates overlaid (`interflex`); common support shaded; the values of S in the text marked |
| "The design is credible" | Event study; RD plot; balance plot; first-stage plot; density test | Event study: every pre-period coefficient, the reference period at zero, onset marked, the same y-axis as the effect; RD: binned means on both sides, the local fit, the bandwidth, the cutoff line; balance: standardized differences, not p-values |
| "The result is robust" | Specification curve with dashboard; sensitivity contour or breakdown plot; leave-one-out plot | Primary marked; inclusion rule in the caption; contour plot with benchmark covariates labeled |
| "Here is the variation the design uses" | Small multiples of the treatment by unit over time; distribution by group; map | Units labeled directly; shared axes across panels; a map uses an equal-area projection, stated class breaks, and a visible NA category |
| "This is the puzzle" (motivation) | Raw trend or scatter with labeled units | The notable units labeled on the figure, not in the caption |

## Rules

- **Title states the claim** in a sentence a reader could repeat; subtitle
  carries the estimand and sample; caption carries the model, standard
  errors, and N.
- **Axes in substantive units**, labeled in words; a zero line when zero
  means "no effect"; no truncated axes that exaggerate; log axes labeled in
  original units.
- **Uncertainty always drawn**, and which interval stated once.
- **Colorblind-safe palette** (Okabe–Ito), at most five series, direct
  labels over legends when the plot allows; the same color means the same
  thing across every figure in the paper.
- **No dual axes, 3D, pie charts, gradient fills, or decorative gridlines.**
- **Small multiples over overplotting.** If a legend needs decoding, split
  the panels.
- **One claim per figure.** If the caption needs two sentences to say what
  the figure shows, it is two figures.
- **Sizes for print:** single column about 3.3 in wide, double column
  6.5–7 in; text at 8–10 pt after scaling; vector PDF for the manuscript,
  300-dpi PNG for slides; the underlying data saved as CSV per figure
  (`save_figure()` does this).
- **Time on the x-axis** runs left to right; events marked with a vertical
  line and a label, not a legend entry.

## What referees fault

- A coefficient plot mixing variables on different scales with no
  standardization or grouping.
- Intervals computed from a different standard-error choice than the
  tables.
- An event study without the reference period, or with the pre-period
  cropped.
- Marginal effects drawn beyond the moderator's support.
- A map without a projection statement or with quantile breaks that hide
  the variation the text describes.
- Colors that carry meaning in one figure and none in the next.
- Figures the text never refers to, or refers to by the variable name
  rather than the claim.
