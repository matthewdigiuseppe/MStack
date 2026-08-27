# 00-power.R — power analysis via DeclareDesign (MStack template).
# Copied from the MStack plugin by /mstack:power-analysis; adapt the PARAMETERS
# block and the declared design to the actual study, then run:
#   Rscript code/00-power.R
#
# Why DeclareDesign as the default: it forces the model, inquiry, data strategy
# and answer strategy to be explicit, and the same skeleton generalizes across
# experiments, surveys, panels, and hierarchical designs. Fall back to `pwr`
# only for a genuine textbook two-sample case, and say why in this header.

library(DeclareDesign)
library(ggplot2)

# ---- PARAMETERS (edit these) -------------------------------------------------
set.seed(20260101)
N_GRID       <- c(500, 1000, 1500, 2000, 3000)  # candidate sample sizes
EFFECT_GRID  <- c(0.05, 0.10, 0.15, 0.20)       # effects in outcome-SD units
PLANNED_N    <- 1500                             # the N you can actually afford
POWER_TARGET <- 0.80
SIMS         <- 500                              # raise for the final run
# ------------------------------------------------------------------------------

# ---- The design (two-arm individual randomization; adapt to the real study) --
make_design <- function(N, effect) {
  declare_model(
    N = N,
    U = rnorm(N),
    potential_outcomes(Y ~ effect * Z + U)
  ) +
    declare_inquiry(ATE = mean(Y_Z_1 - Y_Z_0)) +
    declare_assignment(Z = complete_ra(N, prob = 0.5)) +
    declare_measurement(Y = reveal_outcomes(Y ~ Z)) +
    declare_estimator(Y ~ Z, .method = lm_robust, inquiry = "ATE")
  # Adaptations that matter:
  #  - clustered designs: cluster_ra() + declare_model(clusters, ICC)
  #  - attrition: a declare_measurement step dropping completers at rate a
  #  - covariate adjustment: add covariates to the model and the estimator
  #  - panel/FE: simulate the within-unit variation that identifies the effect
}

# ---- Diagnose over the grid --------------------------------------------------
grid <- expand.grid(N = N_GRID, effect = EFFECT_GRID)
diagnoses <- lapply(seq_len(nrow(grid)), function(i) {
  d <- diagnose_design(make_design(grid$N[i], grid$effect[i]),
                       sims = SIMS, bootstrap_sims = 0)
  data.frame(N = grid$N[i], effect = grid$effect[i],
             power = d$diagnosands_df$power[1])
})
res <- do.call(rbind, diagnoses)
print(res)

# MDE at the planned N: smallest gridded effect reaching the power target.
mde_row <- subset(res, N == PLANNED_N & power >= POWER_TARGET)
mde <- if (nrow(mde_row)) min(mde_row$effect) else NA
cat(sprintf(
  "\nPlanned N = %d: MDE at %.0f%% power = %s (SD units)\n",
  PLANNED_N, 100 * POWER_TARGET,
  ifelse(is.na(mde), "NOT REACHED on this grid — extend EFFECT_GRID or raise N", mde)
))

# ---- Sensitivity curve -------------------------------------------------------
dir.create("output/figures", recursive = TRUE, showWarnings = FALSE)
p <- ggplot(res, aes(N, power, color = factor(effect))) +
  geom_line() + geom_point() +
  geom_hline(yintercept = POWER_TARGET, linetype = "dashed") +
  labs(
    title = "Power by sample size and effect size",
    subtitle = sprintf("%d simulations per cell; dashed line = %.0f%% target",
                       SIMS, 100 * POWER_TARGET),
    x = "N", y = "Power", color = "Effect (SD)"
  ) +
  theme_minimal()
ggsave("output/figures/power-sensitivity.pdf", p,
       width = 6.5, height = 4, units = "in")
cat("Wrote output/figures/power-sensitivity.pdf\n")
