# spec-curve.R — specification-curve helpers (MStack).
# Copied from the MStack plugin by /mstack:robustness; source() from
# 06-robustness-table-and-curve.R.
#
# Expects the long results data frame 05-robustness.R builds:
#   spec_name, dimension, coef, se, ci_low, ci_high, n
# with exactly one row where spec_name == "primary".

library(ggplot2)

# Ranked coefficient curve with the primary spec highlighted.
plot_spec_curve <- function(res, title = "Specification curve") {
  res$rank <- rank(res$coef, ties.method = "first")
  res$primary <- res$spec_name == "primary"
  ggplot(res, aes(rank, coef)) +
    geom_hline(yintercept = 0, color = "grey55") +
    geom_linerange(aes(ymin = ci_low, ymax = ci_high), color = "grey65") +
    geom_point(aes(color = primary, size = primary)) +
    scale_color_manual(values = c(`FALSE` = "grey35", `TRUE` = "#D55E00"), guide = "none") +
    scale_size_manual(values = c(`FALSE` = 1.4, `TRUE` = 2.6), guide = "none") +
    labs(
      title = title,
      subtitle = sprintf("%d specifications; primary highlighted; bars are 95%% CIs",
                         nrow(res)),
      x = "Specifications, ranked by estimate", y = "Coefficient"
    ) +
    theme_minimal() +
    theme(panel.grid.minor = element_blank())
}

# Verdict per /mstack:robustness: Stable / Sensitive / Fragile.
summarize_robustness <- function(res) {
  primary <- res[res$spec_name == "primary", ]
  stopifnot(nrow(primary) == 1)
  alts <- res[res$spec_name != "primary", ]
  same_sign <- sign(alts$coef) == sign(primary$coef)
  sig       <- alts$ci_low > 0 | alts$ci_high < 0
  agree     <- mean(same_sign & sig)
  verdict <- if (agree > 0.8) "Stable"
             else if (agree >= 0.4) "Sensitive"
             else "Fragile"
  list(
    n_specs = nrow(alts),
    share_same_sign = mean(same_sign),
    share_agreeing = agree,
    verdict = verdict,
    text = sprintf(
      "%d alternatives: %.0f%% share the primary's sign, %.0f%% agree in sign and significance. Verdict: %s.",
      nrow(alts), 100 * mean(same_sign), 100 * agree, verdict
    )
  )
}
