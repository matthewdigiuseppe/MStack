# theme_mstack.R — MStack figure conventions as code.
# Copy into the paper as code/theme_mstack.R and source() it from 03-figures.R
# so the replication package is self-contained.
#
# Provides:
#   okabe_ito           colorblind-safe palette (max 5 series per figure)
#   theme_mstack()      ggplot theme (minimal, journal-friendly)
#   scale_color_mstack() / scale_fill_mstack()
#   save_figure()       writes <name>.pdf + <name>.png + <name>-data.csv

library(ggplot2)

okabe_ito <- c(
  "#0072B2", "#D55E00", "#009E73", "#E69F00", "#CC79A7",
  "#56B4E9", "#F0E442", "#000000"
)

theme_mstack <- function(base_size = 11, base_family = "") {
  theme_minimal(base_size = base_size, base_family = base_family) +
    theme(
      plot.title          = element_text(face = "bold", size = rel(1.1)),
      plot.subtitle       = element_text(color = "grey30", size = rel(0.9)),
      plot.caption        = element_text(color = "grey40", size = rel(0.75), hjust = 0),
      plot.title.position = "plot",
      panel.grid.minor    = element_blank(),
      axis.title          = element_text(size = rel(0.9)),
      legend.position     = "bottom",
      legend.title        = element_blank(),
      strip.text          = element_text(face = "bold")
    )
}

scale_color_mstack <- function(...) scale_color_manual(values = okabe_ito, ...)
scale_fill_mstack  <- function(...) scale_fill_manual(values = okabe_ito, ...)

# save_figure(fig_1_headline, "fig-1-headline", data = plot_df, width = 6.5, height = 4)
# Writes output/figures/<name>.pdf, .png, and <name>-data.csv so the figure can
# be rebuilt from the CSV alone.
save_figure <- function(plot, name, data = NULL,
                        width = 6.5, height = 4, dir = "output/figures") {
  dir.create(dir, recursive = TRUE, showWarnings = FALSE)
  ggsave(file.path(dir, paste0(name, ".pdf")), plot,
         width = width, height = height, units = "in", device = cairo_pdf)
  ggsave(file.path(dir, paste0(name, ".png")), plot,
         width = width, height = height, units = "in", dpi = 300)
  if (!is.null(data)) {
    utils::write.csv(data, file.path(dir, paste0(name, "-data.csv")),
                     row.names = FALSE)
  }
  invisible(plot)
}
