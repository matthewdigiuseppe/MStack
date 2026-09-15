# Survey and survey-experiment design conventions

Read by `/mstack:survey-build` alongside the bot-defense reference
(`survey-bot-defenses.md`, or the user's `agent-disclosure` skill). This
file is about the instrument and the experiment; the other is about
keeping agents out of the sample.

## Instrument design

- **Wording:** one idea per item; concrete, specific language; balanced
  stems; avoid agree/disagree batteries (acquiescence) in favor of
  construct-specific response options; fully labeled scales of five to
  seven points; a middle option and a "don't know" only where the construct
  needs them, and the choice recorded in the design file.
- **Order:** pre-treatment covariates before the treatment; the treatment
  before the outcomes; the primary outcome immediately after the treatment
  unless decay is the estimand; sensitive items late; item order randomized
  within batteries; some items reverse-coded.
- **Pretreatment:** respondents already exposed to the treatment in the
  world (Druckman & Leeper 2012); measure prior exposure and prior attitudes
  before the treatment so heterogeneity by exposure can be examined.
- **Attention vs. manipulation checks** (Kane & Barabas 2019): attention
  checks screen for reading and belong before treatment or serve as
  exclusions only if pre-registered; manipulation checks measure whether the
  treatment was received and should not condition the sample post-treatment
  (that is selection on a post-treatment variable). Report both by arm.
- **Open-ended items:** at least one, placed to serve both mechanism
  evidence and the quality/bot scoring protocol.
- **Length and burden:** a median completion target, timing per page
  recorded as embedded data, a pilot of 50–100 completes to calibrate timing,
  fail rates, and floor or ceiling effects.
- **Weights and quotas:** quotas on the sample frame's known margins if
  balance matters; raking weights for descriptive estimands; causal
  contrasts reported unweighted with weighted as a check.

## Experimental components

- **Vignettes:** information equivalence across arms (Dafoe, Zhang &
  Caughey 2018): a manipulation that also changes what respondents infer
  about other attributes is a compound treatment; pretest and, if needed,
  hold the inferred attributes constant explicitly.
- **Conjoints:** five to eight attributes with modest level counts;
  randomization with any restrictions documented and the AMCE interpreted
  over the restricted distribution (Hainmueller, Hopkins & Yamamoto 2014);
  attribute order randomized across respondents and fixed within; five to
  ten tasks with a satisficing check; forced choice plus a rating; marginal
  means for subgroup comparisons (Leeper, Hobolt & Tilley 2020); power in
  terms of profiles and levels (Schuessler & Freitag 2020).
- **Sensitive-item designs:** list experiments, endorsement experiments,
  randomized response; all cost power and need design-specific analysis
  and a floor/ceiling check.
- **Randomization mechanics:** the survey platform's randomizer set to
  present evenly, assignment written to embedded data, blocking on
  pre-treatment covariates via quotas where feasible, a seed or export that
  makes the assignment reproducible.

## Sampling

- Frame and provider (Prolific, YouGov, Lucid/Cint, Qualtrics panels,
  probability panels) with the provider's known quality profile recorded;
  attention and bot contamination differ by provider and over time.
- Recruitment dates, incentives, screener criteria, and the number screened
  out.
- Consent, debriefing for any deception, IRB approval number, and data
  minimization (region rather than IP; no identifiers stored with
  responses).

## Data capture

Embedded data to record: assignment and condition labels, timing per page,
device and browser, referrer, quota cell, and the probe outcomes from the
bot-defense manifest. Everything needed to reconstruct the exclusion rules
in `/mstack:preregister` and to report attrition by arm.

## Analysis link

The estimand is the ITT among all assigned unless the preregistration
says otherwise; report attrition by arm and bound differential attrition;
covariate adjustment only as preregistered (Lin 2013); standard errors
clustered by respondent when respondents complete multiple tasks.
