---
name: power-analysis
description: Computes sample size and minimum detectable effect with R code. Writes a power-analysis report to .mstack/power-analysis.md. Use after /design-research and before /preregister.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
---

# /mstack:power-analysis

**Stage:** design
**Voice:** methodologist

## When to invoke

After `/design-research` chooses a design. Before fielding. The prereg's "Sample" section pulls its target N from this skill's output.

## Procedure

1. **Load.** `.mstack/hypotheses.md`, `.mstack/design-research.md`, `.mstack/lit-map.md` (look up effect sizes from comparable studies).

2. **Decide the inputs.**
   - **Effect-size target.** Either:
     - Smallest effect of substantive interest (SESOI), or
     - Median effect from comparable studies in `lit-map.md`.
     Be honest: published effects are inflated; aim conservative.
   - **α** (typically 0.05, two-sided).
   - **Power** (typically 0.80; for high-stakes preregistered work, 0.90).
   - **Design constants** — clustering, ICC, attrition rate, blocking.

3. **Write `code/00-power.R`** that:
   - Loads `pwr`, or `DeclareDesign`, or `Superpower` depending on the design.
   - Implements either an analytic formula (simple cases) or simulation (FE, panel, hierarchical, conjoint).
   - For experiments / surveys: report N for power = 0.80 *and* MDE at the user's planned N.
   - For observational with FE: simulate to find effective N for identification.
   - Saves a sensitivity curve (power vs. effect size; MDE vs. N) to `output/figures/power-sensitivity.pdf`.

4. **Run** `Rscript code/00-power.R`. Capture results.

5. **Write the report** to `.mstack/power-analysis.md`:
   - Inputs (with sources / justifications).
   - Method (analytic vs. simulation; software; replicable seed).
   - Results table: target N, MDE at planned N, power at expected effect, ICC/attrition assumed.
   - Sensitivity curve description and pointer to the figure.
   - **Verdict** — at the planned N, can the design detect the effect of substantive interest? If no, recommend either a larger N or a redesign.

6. **Update `.mstack/config.yaml`** stats section if useful.

## Outputs

- `code/00-power.R` — reproducible power calculation.
- `output/figures/power-sensitivity.pdf` — sensitivity curve.
- `.mstack/power-analysis.md` — report.
- Summary block: target N, MDE at planned N, verdict.

## Anti-patterns to refuse

- **Power calc on the wrong effect size.** Using the published median effect from a literature with publication bias inflates expected effect and underpowers the study.
- **Black-box defaults.** Justify ICC, attrition, clustering — every assumption changes the answer.
- **Skipping the sensitivity curve.** A single number for power is not informative; the curve is.

## When to call other skills

- Before: `/design-research`, `/lit-map` (for effect-size benchmarks).
- After: `/preregister` (which quotes this report verbatim).
