---
name: results-audit
description: Staff-statistician audit of the analysis. Catches off-by-one errors, sample-size mismatches, SE-clustering mistakes, p-hacking risk, and forking-paths exposure. Run after /analyze and before /draft-section results. Analog to gstack's /review.
user-invocable: true
allowed-tools:
  - Read
  - Bash
  - Grep
  - Glob
  - Write
---

# /mstack:results-audit

**Stage:** analyze (post-analysis, pre-writing)
**Voice:** staff-statistician

## When to invoke

After `/analyze` writes the primary table. Before `/draft-section results`. This skill is the one your future self wishes had run before the R2 reviewer found the same problem in three pages.

## Procedure

1. **Load.**
   - `code/01-clean.R`, `code/02-analyze.R`, `code/04-tables.R`.
   - `data/codebook.md` for variable definitions.
   - `output/tables/`, `output/models/`, `output/analyze-log.md`.
   - `prereg/osf-prereg.md` if preregistered.

2. **Run the audit checklist.** For each item, either confirm pass or write the failure to the audit report.

   ### Sample integrity
   - [ ] N in the descriptive table matches N in the primary regression (or differs only by documented exclusions).
   - [ ] N is consistent across primary + secondary tables (or differences are documented).
   - [ ] No fully-dropped variable in the primary spec (e.g., a control with all NAs).
   - [ ] If FE-included: effective sample for identification is reported (units with within-variation).

   ### Specification integrity
   - [ ] Primary spec matches prereg's "Primary analysis" word-for-word (variables, sample, SE).
   - [ ] FE dimensions are justified (not just "everyone uses two-way FE").
   - [ ] Clustering matches the dependence structure described in `/identification-review`.
   - [ ] Standard errors are not naïve when the design has obvious dependence (panel, geographic, dyadic).

   ### Inference integrity
   - [ ] Multiple-comparison adjustment applied (or explicitly waived with justification) when ≥ 5 hypotheses are tested.
   - [ ] Confidence intervals included (not just stars).
   - [ ] Effect sizes reported in interpretable units (% change, SD of outcome, vs. baseline).
   - [ ] No "marginally significant" or "approached significance" — give the number.

   ### Forking-paths exposure
   - [ ] Specification curve plot or table exists showing primary among reasonable alternatives.
   - [ ] Outcome was preregistered or unambiguously defined upstream.
   - [ ] Treatment / IV operationalization matches prereg (or deviation is logged).
   - [ ] Sample restrictions match prereg.

   ### Reproducibility
   - [ ] `01-clean.R` → `02-analyze.R` → `04-tables.R` runs end-to-end on a fresh R session (test if feasible: `Rscript -e 'source("code/01-clean.R"); source("code/02-analyze.R"); source("code/04-tables.R")'`).
   - [ ] `output/analyze-log.md` matches the tables on disk.
   - [ ] No hard-coded paths.
   - [ ] `sessionInfo()` is captured somewhere.

3. **Run the failures.** For each failed check, write a one-paragraph diagnosis: what is wrong, where (file + line), and the fix.

4. **Verdict.**
   - **Pass** — all checks clean. Proceed to `/robustness` then `/draft-section results`.
   - **Conditional pass** — minor failures fixable in code without re-spec. List them.
   - **Fail** — at least one specification, sample, or inference issue. Halt drafting until resolved.

5. **Save** to `.mstack/results-audit-<YYYY-MM-DD>.md`.

## Outputs

- `.mstack/results-audit-<date>.md` — full checklist with pass/fail and diagnoses.
- A summary block to the user: top 3 issues, verdict, suggested next action.

## Anti-patterns to refuse

- **Checking only the things that are already right.** If everything passes, you didn't audit hard enough; double-check sample sizes by re-running the dataset.
- **Audit by eyeball.** Use Grep / Bash to verify specs in code, not by reading prose.
- **Soft verdicts.** A `Conditional pass` with five items is a `Fail`.

## When to call other skills

- Pre-fail: re-run `/analyze` after fixing.
- Pre-pass: `/robustness` next, then `/viz`, then `/draft-section results`.
