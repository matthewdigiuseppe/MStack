# 00-codebook.R — auto-generate data/codebook.md from the analytic dataset.
# Copied from the MStack plugin by /mstack:codebook; adapt the PARAMETERS block,
# then run:  Rscript code/00-codebook.R
# Idempotent — safe to re-run whenever data/clean/analytic.rds changes.

# ---- PARAMETERS (edit these) -------------------------------------------------
PATH_IN   <- "data/clean/analytic.rds"
PATH_OUT  <- "data/codebook.md"
KEY_COLS  <- c()      # unit-of-analysis key, e.g. c("country_id", "year")
UNIT      <- ""       # human-readable unit, e.g. "country-year"
SOURCE    <- "code/01-clean.R"
# ------------------------------------------------------------------------------

suppressPackageStartupMessages(library(dplyr))

df <- readRDS(PATH_IN)

fmt <- function(x, d = 2) ifelse(is.na(x), "", formatC(x, digits = d, format = "f"))

describe_var <- function(x, name) {
  n_miss <- sum(is.na(x))
  label  <- attr(x, "label"); if (is.null(label)) label <- ""
  type   <- class(x)[1]
  if (is.numeric(x)) {
    rng  <- paste0("[", fmt(min(x, na.rm = TRUE)), ", ", fmt(max(x, na.rm = TRUE)), "]")
    dist <- paste0("mean ", fmt(mean(x, na.rm = TRUE)), " (sd ", fmt(sd(x, na.rm = TRUE)),
                   "); median ", fmt(median(x, na.rm = TRUE)))
  } else {
    lv   <- sort(table(x), decreasing = TRUE)
    rng  <- paste0(length(lv), " levels")
    dist <- if (length(lv)) paste0("mode ", names(lv)[1], " (", lv[1], ")") else ""
  }
  tibble(
    variable = name, label = label, type = type, range = rng, distribution = dist,
    missing = sprintf("%d (%.1f%%)", n_miss, 100 * n_miss / length(x)),
    miss_share = n_miss / length(x)
  )
}

cb <- bind_rows(lapply(names(df), function(v) describe_var(df[[v]], v)))

# ---- Suspicious-pattern flags ------------------------------------------------
flags <- character(0)
flag  <- function(msg) flags <<- c(flags, msg)

for (i in seq_len(nrow(cb))) {
  if (cb$miss_share[i] > 0.30)
    flag(sprintf("`%s`: %.0f%% missing — document imputation or exclude.",
                 cb$variable[i], 100 * cb$miss_share[i]))
  if (cb$label[i] == "")
    flag(sprintf("`%s`: no label attribute — add one in %s.", cb$variable[i], SOURCE))
}
for (v in names(df)) {
  x <- df[[v]]
  if (is.numeric(x) && length(unique(na.omit(x))) <= 1)
    flag(sprintf("`%s`: constant — carries no information.", v))
  if (is.numeric(x) && length(x) > 0) {
    at_cap <- mean(x %in% range(x, na.rm = TRUE), na.rm = TRUE)
    if (!is.na(at_cap) && at_cap > 0.25 && length(unique(na.omit(x))) > 2)
      flag(sprintf("`%s`: %.0f%% of values at the min/max — check winsorizing/caps.",
                   v, 100 * at_cap))
  }
  if (inherits(x, "Date") && any(x > Sys.Date(), na.rm = TRUE))
    flag(sprintf("`%s`: contains future dates.", v))
}
num <- df[vapply(df, is.numeric, logical(1))]
if (ncol(num) >= 2) {
  cm <- suppressWarnings(cor(num, use = "pairwise.complete.obs"))
  cm[lower.tri(cm, diag = TRUE)] <- NA
  dup <- which(abs(cm) > 0.99, arr.ind = TRUE)
  for (k in seq_len(nrow(dup)))
    flag(sprintf("`%s` and `%s`: |r| > 0.99 — apparent duplicates.",
                 rownames(cm)[dup[k, 1]], colnames(cm)[dup[k, 2]]))
}
if (length(KEY_COLS) && anyDuplicated(df[, KEY_COLS, drop = FALSE]))
  flag(sprintf("unit of analysis not unique on (%s).", paste(KEY_COLS, collapse = ", ")))

# ---- Render ------------------------------------------------------------------
lines <- c(
  "# Codebook",
  "",
  sprintf("- **Dataset:** `%s` — N = %d, K = %d", PATH_IN, nrow(df), ncol(df)),
  sprintf("- **Unit of analysis:** %s", ifelse(UNIT == "", "(set UNIT in 00-codebook.R)", UNIT)),
  sprintf("- **Generated:** %s by `code/00-codebook.R` (source pipeline: `%s`)",
          format(Sys.Date()), SOURCE),
  "",
  "| Variable | Label | Type | Range | Distribution | Missing |",
  "|---|---|---|---|---|---|",
  sprintf("| `%s` | %s | %s | %s | %s | %s |",
          cb$variable, cb$label, cb$type, cb$range, cb$distribution, cb$missing),
  "",
  "## Flags",
  ""
)
lines <- c(lines, if (length(flags)) paste0("- ", flags) else "- None.")
writeLines(lines, PATH_OUT)
cat(sprintf("Wrote %s (%d variables, %d flags)\n", PATH_OUT, nrow(cb), length(flags)))
