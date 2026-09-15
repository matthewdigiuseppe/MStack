---
name: results-audit
description: Staff-statistician audit of the analysis — sample-size consistency across tables, spec-vs-prereg match, clustering, multiple comparisons, forking-paths exposure, end-to-end reproducibility. Use after /mstack:analyze and before drafting results, or whenever the user asks to check the analysis or the numbers look off.
allowed-tools:
  - Read
  - Bash
  - Grep
  - Glob
  - Write
---

# /mstack:results-audit

**Stage:** analyze (post-analysis, pre-writing) · **Voice:** staff-statistician

After `/mstack:analyze` writes the primary table, before `/mstack:draft-section results`. Finds what the R2 reviewer would otherwise find.

## Procedure

1. **Load** `code/01-clean.R`, `code/02-analyze.R`, `code/04-tables.R`, `data/codebook.md`, `output/tables/`, `output/models/`, `output/analyze-log.md`, and `prereg/osf-prereg.md` if preregistered.
2. **Checklist.** Confirm each item or write the failure to the report.

   **Sample integrity**
   - [ ] N in the descriptive table matches N in the primary regression (or differs only by documented exclusions).
   - [ ] N consistent across primary and secondary tables, or differences documented.
   - [ ] No fully-dropped variable in the primary spec (e.g. a control with all NAs).
   - [ ] With FE: the effective identifying sample (units with within-variation) is reported.

   **Specification integrity**
   - [ ] Primary spec matches the prereg's primary analysis word-for-word (variables, sample, SE).
   - [ ] FE dimensions justified, not "everyone uses two-way FE".
   - [ ] Clustering matches the dependence structure in `/mstack:identification-review`.
   - [ ] No naive SEs under obvious dependence (panel, geographic, dyadic).

   **Inference integrity**
   - [ ] Multiple-comparison adjustment applied, or explicitly waived with justification, when ≥ 5 hypotheses are tested.
   - [ ] Confidence intervals reported, not just stars.
   - [ ] Effect sizes in interpretable units (% change, outcome SD, vs. baseline).
   - [ ] No "marginally significant" or "approached significance"; give the number.

   **Forking-paths exposure**
   - [ ] A specification curve or table shows the primary among reasonable alternatives.
   - [ ] Outcome preregistered or unambiguously defined upstream.
   - [ ] Treatment / IV operationalization and sample restrictions match the prereg, or the deviation is logged.

   **Reproducibility**
   - [ ] The numbered pipeline runs end-to-end in a fresh R session, every `code/[0-9]*.R` in ascending order, skipping `00-fetch-*` (test when feasible: `Rscript -e 'for (f in sort(list.files("code", pattern = "^[0-9].*[.]R$", full.names = TRUE))) if (!grepl("00-fetch", f)) source(f)'`).
   - [ ] `output/analyze-log.md` matches the tables on disk.
   - [ ] No hard-coded paths; `sessionInfo()` captured somewhere.

3. **Diagnose each failure** in one paragraph: what is wrong, where (file + line), the fix.
4. **Verdict:** **Pass** (all clean), **Conditional pass** (minor failures fixable in code without re-specification; list them), **Fail** (at least one specification, sample, or inference issue; halt drafting until resolved).
5. **Save** to `.mstack/results-audit-<YYYY-MM-DD>.md`.

## Outputs

- `.mstack/results-audit-<date>.md` — checklist with pass / fail and diagnoses.
- Summary block: top 3 issues, verdict, next action.

## Anti-patterns

- **Auditing only what is already right.** If everything passes, double-check sample sizes by re-running the dataset.
- **Audit by eyeball.** Verify specs in code with Grep / Bash, not by reading prose.
- **Soft verdicts.** A conditional pass with five items is a fail.

## Next

Fail → fix, re-run `/mstack:analyze`. Pass → `/mstack:robustness`, then `/mstack:viz`, then `/mstack:draft-section results`.
