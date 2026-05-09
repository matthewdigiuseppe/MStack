# 02-analyze.R — primary models.
# Inputs:  data/clean/analytic.rds
# Outputs: output/tables/*.tex

library(tidyverse)
library(fixest)
library(modelsummary)
library(here)

# /analyze writes here.
