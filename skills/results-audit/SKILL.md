---
name: results-audit
description: Staff-statistician audit of the full analysis against a catalog of the bugs that get papers corrected — duplicated merges, sentinel codes as numbers, lags across gaps, post-treatment controls, wrong clustering, two-way FE under staggered adoption, logit coefficients compared across models, prose numbers that do not match the tables — plus sample-size consistency, spec-vs-prereg match, multiple comparisons, forking-paths exposure, and an end-to-end reproducibility run. Use after /mstack:analyze and before drafting results, or whenever the user asks to check the analysis or the numbers look off.
allowed-tools:
  - Read
  - Bash
  - Grep
  - Glob
  - Write
---

# /mstack:results-audit

**Stage:** analyze (post-analysis, pre-writing) · **Voice:** staff-statistician

After `/mstack:analyze` writes the primary table, before `/mstack:draft-section results`. Finds what the R2 reviewer, or the replicator two years later, would otherwise find. The audit is done in code, not by reading prose about the code.

## Procedure

1. **Load** `code/01-clean.R`, `code/02-analyze.R`, `code/04-tables.R`, `data/codebook.md`, `data/raw/PROVENANCE.md` (sentinel codes and identifier schemes per source), `output/tables/`, `output/models/`, `output/analyze-log.md`, `prereg/osf-prereg.md` if preregistered, `.mstack/identification-review-*.md` (clustering level, tests promised), `.mstack/hypotheses.md` (estimands), `.mstack/config.yaml` (`design.type`).
2. **Read** `${CLAUDE_PLUGIN_ROOT}/references/audit-catalog.md` (the bug catalog with detection snippets) and the design section of `${CLAUDE_PLUGIN_ROOT}/references/estimation-conventions.md`.
3. **Checklist.** Confirm each item in code or write the failure to the report. Run the catalog's detection snippets against the actual data and scripts rather than reasoning about them.

   **Data assembly** (against the catalog's first table)
   - [ ] No duplicate unit-years after any join; row counts asserted at every join; no many-to-many join without a written reason.
   - [ ] Sentinel and missing codes from `PROVENANCE.md` are recoded before arithmetic; a sentinel scan of integer-coded variables is clean.
   - [ ] Merges use codes and crosswalks; unmatched keys were listed and resolved.
   - [ ] Lags and leads are computed within unit after ordering, with no gaps crossed; the direction of every shift is what the theory intends.
   - [ ] Year alignment across sources (election year, fieldwork year, fiscal year) is correct; unit-boundary changes (NUTS, FIPS) are handled.
   - [ ] Sample restrictions are applied identically to descriptives and models; N in Table 1 matches N in the primary regression or differs by a documented exclusion; N is consistent across columns or the difference is noted.

   **Specification**
   - [ ] Primary spec matches the prereg's primary analysis word-for-word (variables, sample, estimator, SE), or the deviation is logged.
   - [ ] Every control is pre-treatment by the DAG in `theory.md`; no mediator or consequence of treatment is conditioned on.
   - [ ] The estimator fits the design (no plain two-way FE under staggered adoption; `rdrobust` with a stated bandwidth; weak-IV-robust intervals reported when the first stage is modest; PPML for flows with zeros).
   - [ ] FE dimensions justified; the share of units with within-variation in treatment is reported.
   - [ ] Clustering matches the assignment level and the dependence structure in the identification review; the cluster count is adequate or the wild bootstrap is used; no naive SEs under panel, spatial, or dyadic dependence.
   - [ ] Interactions report marginal effects at moderator values with common support checked; nonlinear models report AMEs, and no logit or probit coefficients are compared across models or samples.
   - [ ] No `log(1 + y)` on an outcome with many zeros without a stated alternative.

   **Inference**
   - [ ] Multiple-comparison adjustment applied, or explicitly waived with justification, when more than one hypothesis is tested in a family.
   - [ ] Confidence intervals reported, not just stars; each is consistent with its SE.
   - [ ] Effect sizes in interpretable units (percentage points, outcome SD, vs. baseline) and the estimand named in every table note.
   - [ ] No "marginally significant" or "approached significance"; nulls are read against the SESOI.
   - [ ] Seeds set for every stochastic step (bootstrap, randomization inference, simulation, imputation).

   **Forking-paths exposure**
   - [ ] A specification curve or table shows the primary among the defensible alternatives, with the inclusion rule stated.
   - [ ] Outcome and index construction preregistered or unambiguously defined upstream.
   - [ ] Treatment operationalization and sample restrictions match the prereg, or the deviation is logged.
   - [ ] The falsification tests promised in the identification review were run and reported, whatever they showed.

   **Reporting**
   - [ ] Every number quoted in `paper/sections/results.tex` appears in a table or the log (run the catalog's grep comparison); percent vs. percentage points and SD vs. raw units are consistent.
   - [ ] Figures and tables come from the same model run (timestamps of `output/models/*.rds`, `output/tables/*`, `output/figures/*` in order).
   - [ ] Causal language matches the design.

   **Reproducibility**
   - [ ] The numbered pipeline runs end-to-end in a fresh R session, every `code/[0-9]*.R` in ascending order, skipping `00-fetch-*` (test when feasible: `Rscript -e 'for (f in sort(list.files("code", pattern = "^[0-9].*[.]R$", full.names = TRUE))) if (!grepl("00-fetch", f)) source(f)'`), and the regenerated `output/` matches the committed outputs.
   - [ ] `output/analyze-log.md` matches the tables on disk; no hard-coded paths; `sessionInfo()` captured; package versions pinned or noted.

4. **Diagnose each failure** in one paragraph: what is wrong, where (file + line), what it does to the estimate, the fix.
5. **Verdict:** **Pass** (all clean), **Conditional pass** (minor failures fixable in code without re-specification; list them), **Fail** (at least one data-assembly, specification, sample, or inference issue; halt drafting until resolved).
6. **Save** to `.mstack/results-audit-<YYYY-MM-DD>.md`.

## Outputs

- `.mstack/results-audit-<date>.md` — checklist with pass / fail, the detection output, and diagnoses.
- Summary block: top 3 issues, verdict, next action.

## Anti-patterns

- **Auditing only what is already right.** If everything passes, re-run the duplicate, sentinel, and lag checks on the data itself; those are where the surprises are.
- **Audit by eyeball.** Verify specs in code with Grep / Bash and the catalog's snippets, not by reading prose.
- **Soft verdicts.** A conditional pass with five items is a fail.

## Next

Fail → fix, re-run `/mstack:analyze`. Pass → `/mstack:robustness`, then `/mstack:viz`, then `/mstack:draft-section results`.
