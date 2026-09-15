---
name: power-analysis
description: Target N and minimum detectable effect in R via DeclareDesign simulation, with a sensitivity curve. Use after a design is chosen and before fielding or preregistration, or whenever the user asks about sample size, statistical power, or MDE.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
---

# /mstack:power-analysis

**Stage:** design · **Voice:** methodologist

After `/mstack:design-research`, before fielding. The prereg's Sample section takes its target N from this report.

## Procedure

1. **Load** `.mstack/hypotheses.md`, `.mstack/design-research.md`, `.mstack/lit-map.md` (effect sizes from comparable studies).
2. **Inputs.** Effect-size target: the smallest effect of substantive interest, or the median from comparable studies discounted because published effects are inflated. α (typically 0.05, two-sided); power (0.80; 0.90 for high-stakes preregistered work); design constants (clustering, ICC, attrition, blocking).
3. **Write `code/00-power.R`** by copying `${CLAUDE_PLUGIN_ROOT}/skills/power-analysis/assets/00-power-template.R` and adapting the PARAMETERS block and the declared design. It defaults to **DeclareDesign** (declare model, inquiry, data strategy, answer strategy; `diagnose_design()` over a grid of N and effect sizes) because that generalizes across experimental, survey, FE, panel, hierarchical, and conjoint designs and forces the assumptions into the open. `pwr` only as an analytic sanity check for textbook two-sample cases; `Superpower` only for factorial ANOVA; document any fallback in the script header. Experiments / surveys: report N for 0.80 power and MDE at the planned N. Observational with FE: simulate to find the effective N. Save the sensitivity curve to `output/figures/power-sensitivity.pdf`.
4. **Run** `Rscript code/00-power.R` and capture the results.
5. **Report** to `.mstack/power-analysis.md`, with these sections:
   - **Inputs**, each with its source or justification.
   - **Method** — analytic vs. simulation, software, replicable seed.
   - **Results table** — target N, MDE at planned N, power at the expected effect, ICC / attrition assumed.
   - **Sensitivity curve** — description and pointer to the figure.
   - **Verdict** — can the planned N detect the effect of substantive interest? If not, a larger N or a redesign.
6. Update the `stats` section of `.mstack/config.yaml` if useful.

## Outputs

- `code/00-power.R`, `output/figures/power-sensitivity.pdf`, `.mstack/power-analysis.md`.
- Summary block: target N, MDE at planned N, verdict.

## Anti-patterns

- **The wrong effect size.** A published median from a biased literature underpowers the study.
- **Black-box defaults.** Justify ICC, attrition, clustering; each changes the answer.
- **A single number.** The curve is the result.
- **Reaching for `pwr` first.** DeclareDesign unless the case is genuinely textbook, with the reason in the header.

## Next

`/mstack:preregister`, which quotes this report.
