---
name: power-analysis
description: Computes target N and the minimum detectable effect in R by declaring and diagnosing the design in DeclareDesign — power, bias, coverage, Type S and exaggeration ratios over a grid of N and effect sizes, with the penalties for interactions, clustering, attrition, and conjoint profiles built in — and reports a sensitivity curve. Use after a design is chosen and before fielding or preregistration, or whenever the user asks about sample size, statistical power, or MDE.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
---

# /mstack:power-analysis

**Stage:** design · **Voice:** methodologist

After `/mstack:design-research`, before fielding. The prereg's Sample section takes its target N from this report, and the SESOI in `hypotheses.md` is the effect the study must be able to detect, not the effect the literature reports.

## Procedure

1. **Load** `.mstack/hypotheses.md` (estimand, SESOI, moderators), `.mstack/design-research.md` (data and answer strategy), `.mstack/lit-map.md` (comparable effect sizes and their designs).
2. **Inputs, each with a source written down.**
   - **Effect-size target:** the SESOI from `hypotheses.md`; benchmark against the literature's estimates discounted for publication bias (a published median overstates the true effect; use the lower end or a replication estimate).
   - **α** (0.05 two-sided unless preregistered otherwise) and **power** (0.80; 0.90 for a preregistered primary).
   - **Design constants:** ICC and cluster size for clustered assignment (design effect 1 + (m − 1) ICC), attrition rate (inflate N accordingly), blocking gains, compliance rate for encouragement designs (the CACE needs N scaled by 1/compliance²), the share of units with within-variation for fixed-effects designs.
   - **Interactions and heterogeneity:** an interaction of the same size as the main effect needs about four times the N, and a half-size interaction about sixteen times (Gelman 2018); state the N for every moderation hypothesis separately.
   - **Conjoints:** power in profiles and attribute levels, not respondents alone (Schuessler & Freitag 2020).
3. **Write `code/00-power.R`** by copying `${CLAUDE_PLUGIN_ROOT}/skills/power-analysis/assets/00-power-template.R` and adapting the PARAMETERS block and the declared design. It uses **DeclareDesign** (declare the model, inquiry, data strategy, and answer strategy that `design-research.md` chose; `diagnose_design()` over a grid of N and effect sizes) because the same skeleton generalizes across experimental, survey, FE, panel, hierarchical, and conjoint designs and forces every assumption into code. Diagnose power, bias, RMSE, coverage, and the Type S (wrong sign) and exaggeration (Type M) ratios at the planned N (Gelman & Carlin 2014): an underpowered study that "finds" the effect overstates it. `pwr` only as an analytic sanity check for textbook two-sample cases; `Superpower` only for factorial ANOVA; document any fallback in the script header. Experiments and surveys: report N for the target power at the SESOI and the MDE at the planned N. Observational with fixed effects: simulate the within-unit variation that identifies the effect and report the effective N. Save the sensitivity curve (power against effect size and N) to `output/figures/power-sensitivity.pdf`.
4. **Run** `Rscript code/00-power.R` and capture the results.
5. **Report** to `.mstack/power-analysis.md`, with these sections:
   - **Inputs**, each with its source or justification.
   - **Method** — declared design, simulations, software, replicable seed.
   - **Results table** — target N at the SESOI, MDE at the planned N, power at the literature's effect, Type S and exaggeration ratios at the planned N, ICC / attrition / compliance assumed; a separate row for each moderation hypothesis.
   - **Sensitivity curve** — description and pointer to the figure.
   - **Inconclusive region** — the effect sizes the planned N cannot distinguish from zero, so the preregistration can say what a null will mean.
   - **Verdict** — can the planned N detect the SESOI at the target power? If not, a larger N, a more precise design (blocking, covariate adjustment, repeated measures), or a redesign.
6. Update the `stats` section of `.mstack/config.yaml` if useful.

## Outputs

- `code/00-power.R`, `output/figures/power-sensitivity.pdf`, `.mstack/power-analysis.md`.
- Summary block: target N at the SESOI, MDE at planned N, exaggeration ratio at planned N, verdict.

## Anti-patterns

- **The wrong effect size.** A published median from a biased literature underpowers the study; the SESOI is the target.
- **Black-box defaults.** Justify ICC, attrition, clustering, compliance; each changes the answer.
- **A single number.** The curve and the inconclusive region are the result.
- **Main-effect power for an interaction hypothesis.** State the N the moderation claim needs.
- **Reaching for `pwr` first.** DeclareDesign unless the case is genuinely textbook, with the reason in the header.

## Next

`/mstack:preregister`, which quotes this report.
