# Survey bot/agent defenses (MStack fallback)

Built-in fallback for `/mstack:survey-build`. If the user has the
`agent-disclosure` skill installed, prefer it — it carries the fuller protocol.
The *defenses* are non-negotiable either way; only the source of the playbook
varies.

## Threat model

LLM agents and browser automation now complete online surveys with plausible,
attentive-looking responses. Contamination is the default failure mode of
panel and crowdsourced samples, so defenses are layered — no single probe is
reliable, and every probe has a pre-specified threshold so exclusions never
become researcher degrees of freedom.

## The layers

1. **Timing distributions.** Record per-page submit times (embedded data).
   Floor: reading the page's word count at ~300 wpm; flag pages completed
   below ~40% of the pilot median and totals implausibly fast or slow.
2. **Attention / instructional manipulation checks.** At least two, spaced,
   calibrated so engaged humans fail ≤ 10% (pilot this). Vary the form —
   "select 'somewhat disagree'" plus an IMC embedded in instructions.
3. **Open-ended quality protocol.** At least one open-ended item whose
   scoring rule is defined in advance: requires personal, situated detail;
   flags templated structure, generic completeness, list-like prose, and
   refusal boilerplate. Score blind to condition.
4. **Behavioral probes (JavaScript).** Paste detection on open-endeds, tab
   blur/focus counts, mouse-movement presence. Store as embedded data; absence
   of any interaction telemetry is itself a flag.
5. **Honeypots.** A CSS-hidden field or off-screen item humans never see;
   any response to it is a hard flag.
6. **Direct disclosure item.** Ask outright whether an AI agent completed or
   assisted with the survey, with a no-penalty framing. Instruction-following
   agents disproportionately answer honestly; humans lose nothing.
7. **Duplicate detection.** IP region, device fingerprint hash, and repeated
   free-text collisions across respondents.

## The probe manifest

Every instrument ships a manifest table; `/mstack:preregister` copies the
thresholds into the exclusions section.

| id | probe | trigger/placement | scoring rule | threshold | action |
|---|---|---|---|---|---|
| T1 | page timing | all pages | pct of pilot median | < 40% on ≥ 2 pages | exclude |
| A1/A2 | attention checks | blocks 2, 4 | pass/fail | fail ≥ 2 | exclude |
| O1 | open-ended quality | block 3 | 0–2 rubric | score 0 | exclude |
| H1 | honeypot | block 2 | any response | any | exclude |
| D1 | disclosure item | final block | self-report | affirmative | exclude + count |

Rules: thresholds are set **before** fielding and preregistered; flags are
recorded for every respondent (excluded or not) so contamination rates are
reportable; no ad-hoc exclusions after seeing outcomes.
