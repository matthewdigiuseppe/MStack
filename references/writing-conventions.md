# Writing conventions: what each section must do

Read by `/mstack:draft-section`, `/mstack:abstract-shotgun`, and
`/mstack:coauthor-review`. Voice, rhythm, and vocabulary come from the
user's writing-style skill (`voice.writing_style`); this file is about the
substance each section owes the reader and the reporting rules referees
enforce in quantitative political science.

## Introduction

- Open with the question and why it matters now: a puzzle, a stake, or a
  live disagreement. Not with the literature, and not with "scholars have
  long debated".
- The contribution paragraph makes three moves: what the paper does, what it
  finds (with a number in substantive units), and what changes if the reader
  believes it.
- The identification strategy in one sentence, with the estimand: "we
  estimate the effect of X on Y for [population] using [design]."
- Position against the two or three closest papers, saying what they do not
  answer; the full literature belongs in the theory section, if anywhere.
- Roadmap in one sentence, or none.
- About 10–15% of the manuscript.

## Theory

- The mechanism sentence and its steps; the assumptions each step needs;
  the comparative statics (what should be larger, smaller, earlier, later).
- Observable implications, including the ones that would distinguish the
  mechanism from its rivals; state the rivals.
- Scope conditions, stated as where the mechanism should fail.
- Hypotheses numbered, each with direction and estimand; a theory section
  that ends without a testable statement has not finished.
- Not a literature review with a hypothesis appended.

## Data and measurement

- Unit of analysis, coverage (units, years), and why that sample.
- Each source with its vintage; each key variable's operationalization with
  a validity argument (why this proxy captures the concept, and what it
  misses).
- Descriptive statistics referenced; the variation the design uses shown
  (a figure of treatment by unit and time is worth a page of prose).
- Missingness and how it is handled; sample restrictions with counts.

## Research design

- The estimand, then the identifying assumption in one sentence, then the
  equation with every symbol defined and the fixed effects and clustering
  stated.
- Why this comparison isolates the effect; what the design cannot rule out
  and what falsification tests address it.
- Preregistration status and every deviation, with the original plan.
- The estimator named with its citation when it is not plain OLS.

## Results

- Order: primary estimate, then falsification tests and design checks, then
  mechanism evidence, then heterogeneity, then a one-paragraph robustness
  summary with the sensitivity sentence.
- Each claim tied to a table or figure; point estimate, interval, and
  substantive magnitude against a benchmark (baseline rate, outcome SD, a
  known effect).
- Causal verbs only under a design that identifies the effect; "is
  associated with" otherwise. For nulls, report the interval against the
  SESOI ("we can rule out effects larger than 1 pp"), never "no effect".
- No "marginally significant", "highly significant", or narration of every
  coefficient; report what tests the hypotheses.

## Discussion and conclusion

- What was learned, as the contribution restated with the evidence behind
  it; what the result is not (the estimand's limits: population, margin,
  period).
- The most plausible alternative explanation and why the evidence weighs
  against it.
- Specific limitations (the measurement that is weakest, the assumption
  most likely to fail), not the boilerplate three.
- Implications proportional to the evidence; one concrete next study.

## Abstract

- Question, design with estimand, data, the finding with a number, the
  contribution. Within the journal's cap. No citations, no hedging stack, no
  "this paper argues" without saying what.

## Reporting rules

- Effects to two significant digits; N in every table; percentage points
  distinguished from percent; SD units labeled.
- Tables and figures numbered in order of mention; figures titled by claim.
- Preregistration and deviations reported (registry, date, what changed).
- Human-subjects approval, data-availability, and funding statements where
  the journal requires them; methods cited (estimators, sensitivity tools).

## Complaints referees make most, by section

| Section | Complaint |
|---|---|
| Introduction | Contribution unclear; framed as a gap rather than a claim; no number |
| Theory | Mechanism asserted, not derived; hypotheses not implied by the argument; rivals ignored |
| Data | Proxy validity unargued; sample restrictions unexplained; treatment variation unclear |
| Design | Identifying assumption never stated; SE choice unjustified; no falsification test |
| Results | Causal language overreach; stars-talk; nulls read as zero; heterogeneity fishing |
| Discussion | Boilerplate limitations; implications beyond the estimand |
