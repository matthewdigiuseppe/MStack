# Contribution: what the paper's main idea has to do

Read by `/mstack:claim-sharpen` (what to propose), `/mstack:argument-outline`
(what the supporting claims must add up to), and `/mstack:research-question`
when a contribution sentence needs testing. The methods references say
whether a claim is true; this one is about whether it is worth making and
how far it reaches.

## What a contribution is

A contribution is a change in what a defined set of readers believes. It has
three parts, and `.mstack/spine.md` has a line for each:

- a claim that could be false;
- readers who now believe something else, or do not know which way to bet;
- evidence those readers accept as bearing on it.

A gap is not one of the three. "No one has studied X in Y" describes the
literature, not what a reader will believe afterwards, and many gaps are
empty because the answer is obvious or nothing turns on it. Translate every
gap into "readers of [literature] believe A; this paper shows B."

## Tests of a claim sentence

- It could be false, and the sentence makes clear what would show it.
- It has a direction and, once results exist, a magnitude in substantive
  units.
- A competent reader in the field would have bet against it, or would not
  have known which way to bet, before reading. If everyone would have
  predicted it, the contribution is the precision or the design, and the
  sentence should say that instead.
- It names its population, and the claim's population is the estimand's:
  compliers for an instrument, units near the cutoff for a discontinuity,
  the treated for an ATT, switchers under unit fixed effects (Lundberg,
  Johnson & Stewart 2021).
- It survives "so what?" asked twice. The first answer is usually about the
  literature ("it qualifies A"); the second has to be about politics ("so
  governments that do X should expect Y").
- It is one sentence without "and". Two claims joined by "and" are two
  papers, or a paper and a footnote.

## Types of contribution

Most papers lead with one of these and use at most one more in support.
Naming the type decides what the paper owes and which objection it will
meet.

| Type | Form of the claim | What it owes | Usual failure |
|---|---|---|---|
| New fact | "X is the case", "X has changed", "X is larger than believed" | Measurement validity; coverage; why the fact was not visible before (Gerring 2012 on description as a contribution in its own right) | The fact is unsurprising, or known under another name |
| New effect | "X changes Y by this much, for these units" | A credible design; a magnitude that matters against a benchmark | The sign was known and nothing turns on the size |
| New mechanism | "X moves Y through Z, not W" | Implications on which Z and W differ, tested | "Mechanism evidence" that both channels predict; a mediation regression offered as proof |
| Adjudication | "Where A and B disagree, the evidence favors A when C" | A test both camps accept as diagnostic; the losing account stated at full strength | A strawman B; a test only one side accepts |
| Scope condition | "The accepted finding holds here and fails there, because …" | A reason, stated in advance, for where it breaks | Another case with no account of why the case differs |
| Reversal or informative null | "The accepted effect is absent, or smaller than any size that matters" | The original estimand; enough power; an interval inside the smallest effect of interest (Rainey 2014) | A noisy null reported as "no effect" |
| Measurement | "Measured properly, the answer to Q changes" | Old and new measure side by side on a question readers care about | A better measure that changes no answer |
| Method | "Existing answers are biased by P; this design or estimator removes it" | The bias shown to matter in a real application | A fix for a problem with no demonstrated consequence |
| Synthesis | "One logic accounts for findings explained separately until now" | A prediction the separate accounts do not make | Relabeling |

## The ladder of claims

From narrow to broad: an estimate, a finding (for the sample's population),
a proposition (about a class of units), an implication (for theory or
policy). Each step up is paid for:

- estimate to finding: the identifying assumption and the falsification
  tests;
- finding to proposition: scope conditions argued, heterogeneity examined,
  or the result repeated in a second sample or setting;
- proposition to implication: the mechanism, since an effect whose channel
  is unknown tells no one what to do.

Claim at the highest rung the paper has paid for, and say which rung it is.
Two errors are equally common: a rung too high (a local effect at a cutoff
presented as a law) and a rung too low (a large, well-identified effect
presented as "suggestive evidence of an association").

"What is this a case of?" is the question that moves a finding up the
ladder: the general class of which the paper's case is an instance (trade
shocks and voting as a case of concentrated losses from policies with
diffuse benefits). The answer names the readers beyond the subfield.

## Objections to importance

A referee who accepts the inference can still reject the paper. The forms
the objection takes, and what answers each:

| Objection | Answer |
|---|---|
| "We knew this." | Who predicted otherwise, in print; or a magnitude far from what was assumed |
| "It is small." | A benchmark: the baseline rate, a known effect, the policy's cost, the margin of the outcome that decides something |
| "It is one case." | Why the case is hard, typical, or crucial for the theory; what the scope conditions predict elsewhere |
| "Obvious in hindsight." | The rival prediction as it stood before the result, with the people who held it |
| "No one holds the view you argue against." | Quote it; if it cannot be quoted, the framing is wrong and the contribution is another type |
| "It is a black box." | Mechanism evidence, or an honest claim at the effect rung only |
| "It will not travel." | The off-sample predictions in the theory memo, one of them tested if possible |
| "Of interest to the subfield only." | What it is a case of |

## What may move after the results, and what may not

The paper found is rarely the paper planned, and restating the main idea
once results are in is ordinary scholarship. The line runs between framing
and finding.

- **May move:** which contribution type leads; which literature the paper
  addresses first; the rung of the ladder claimed; the order of the
  argument; the title and abstract.
- **May not move without a label:** the hypotheses, as preregistered or as
  written before the data were seen; which analysis is primary; which
  results are confirmatory. A claim that rests on an analysis chosen after
  seeing results is exploratory, and the paper says so. Presenting a post
  hoc hypothesis as the prediction is HARKing (Kerr 1998), and referees
  look for it.

Two reframings to refuse: the subgroup rescue (the claim rebuilt around the
subset in which the effect appears) and the null dodge (a null against the
smallest effect of interest described as "nuance"). A null from a
well-powered test of a believed effect is a contribution of the reversal
type; frame it as one.

## Signs the claim is under- or overstated

- **Understated:** hedges stacked on a design that licenses a causal verb;
  a magnitude never benchmarked; the general class never named; the finding
  introduced as filling a gap.
- **Overstated:** a population wider than the estimand's; a mechanism
  asserted from a reduced-form effect; policy advice from a local effect;
  a "first to" claim that no search has checked.
