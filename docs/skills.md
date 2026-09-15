# MStack skill reference

Each skill is invokable as `/mstack:<name>` once the plugin is installed (plugin skills are namespaced by the plugin name). Stages match the workflow in [philosophy.md](philosophy.md).

## Stage 0 — Setup

| Skill | Voice | Use when |
|---|---|---|
| `/mstack:mstack-init <name>` | scaffolder | Starting a new paper. Creates the folder layout every other skill assumes. |

## Stage 1 — Ideate

| Skill | Voice | Use when |
|---|---|---|
| `/mstack:research-question` | advisor | Starting a project or reconsidering one. Forcing questions about contribution, identification, feasibility, scoop risk. |
| `/mstack:scope-challenge` | adversarial-advisor | Project is sprawling. "Is this a paper or a footnote?" |
| `/mstack:idea-shotgun` | generative | You have data/topic, want 4–6 alternative angles before committing. |

## Stage 2 — Map

| Skill | Voice | Use when |
|---|---|---|
| `/mstack:pdf-ingest` | archivist | PDFs are on disk. Converts them to token-cheap, section-addressable Markdown with citation front matter and a corpus index. |
| `/mstack:lit-map` | systematic-reviewer | After a candidate question. Identifies must-cite papers and the gap. |
| `/mstack:theory-build` | theorist | After lit-map. Mechanism and steps, signed DAG, scope conditions, rival mechanisms with the observable implications that separate them, the estimand. |
| `/mstack:hypothesis-design` | methodologist | Before any analysis. Operationalized hypotheses with estimand, smallest effect of interest, and a decision rule for nulls. |
| `/mstack:identification-review` | methodologist | Before fielding/analyzing and again before submission. Estimand, identifying assumption, design-specific threats from `references/identification-threats.md`, falsification tests, sensitivity analysis, verdict. |

## Stage 3 — Design

| Skill | Voice | Use when |
|---|---|---|
| `/mstack:design-research` | design-critic | After identification-review. Picks design type, justifies trade-offs. |
| `/mstack:preregister` | preregistration-clerk | Before data collection or analysis. OSF/AsPredicted draft. |
| `/mstack:power-analysis` | methodologist | Before fielding. Sample size + MDE in R. |
| `/mstack:survey-build` | survey-designer | Designing a survey. Bot/agent defenses via `agent-disclosure` if installed, else the built-in fallback. |

## Stage 4 — Build

| Skill | Voice | Use when |
|---|---|---|
| `/mstack:data-acquire` | data-engineer | Start of empirical work. Provenance log for every variable. |
| `/mstack:data-clean` | data-engineer | raw → clean. R conventions via `r-coding-skills` if installed, else the built-in fallback. |
| `/mstack:codebook` | data-engineer | After data-clean stabilizes. Auto-doc + flags suspicious vars. |

## Stage 5 — Analyze

| Skill | Voice | Use when |
|---|---|---|
| `/mstack:analyze` | analyst | After codebook is stable. Main models + tables. |
| `/mstack:robustness` | skeptical-analyst | After main results. Specification curve, sensitivity to unobservables or to the design's assumption, influence, placebos, the sensitivity sentence. |
| `/mstack:viz` | figure-designer | Results stable. Pub-quality figures. |
| `/mstack:results-audit` | staff-statistician | Before writing. Runs the bug catalog in code: merges, sentinel codes, lags, post-treatment controls, clustering, estimator fit, prose-vs-table numbers, reproducibility. |

## Stage 6 — Write

| Skill | Voice | Use when |
|---|---|---|
| `/mstack:draft-section <name>` | writer | Drafting any section. Anchors to the writing-style skill named in `.mstack/config.yaml` (`voice.writing_style`); falls back to a generic academic voice if unset. |
| `/mstack:abstract-shotgun` | writer | After complete draft. 4–6 abstract variants with positioning differences. |
| `/mstack:title-shotgun` | writer | Late-stage. Title options ranked on hook × precision. |
| `/mstack:coauthor-review` | coauthor | On a complete draft. Configurable persona. |
| `/mstack:referee-mock` | referee | Before submission. Reviewer voice from `voice.reviewer_style` if set, else the built-in fallback. |

## Stage 7 — Submit

| Skill | Voice | Use when |
|---|---|---|
| `/mstack:journal-fit` | editor | Submission-ready. 3 target journals + comparison table. |
| `/mstack:submission-pack` | production-editor | Journal chosen. Anonymization sweep, word-count/format checks, staged upload bundle. |
| `/mstack:cover-letter` | editor | After journal-fit. Drafts cover letter. |
| `/mstack:r-and-r` | editor | During R&R. Response-to-reviewers with change log. |

## Stage 8 — Reflect

| Skill | Voice | Use when |
|---|---|---|
| `/mstack:retro` | coach | After acceptance or rejection. What took longest, what to systematize. |
| `/mstack:archive` | replicator | At acceptance. Replication package to the Data and Code Availability Standard, clean-room rebuild, OSF/Dataverse prep. |

## Power tools

| Skill | Use when |
|---|---|
| `/mstack:paper-status` | Opening a session on an existing paper, or asking "what's next?". Runs `bin/mstack-status` (one deterministic inventory: artifacts, dates, stale verdicts, derived stage) and recommends the next skill. |
| `/mstack:careful` | Near a deadline. Destructive commands require confirmation — enforced by the plugin's PreToolUse hook, not just convention. |
| `/mstack:freeze` | Lock edits to one directory — writes elsewhere are denied by the hook. |
| `/mstack:guard` | `/mstack:careful` + `/mstack:freeze`. |
| `/mstack:unfreeze` | Remove the lock. |
| `/mstack:llm-checklist` | An LLM is integral to the design (annotation, simulation, chatbots, classification). Logs model/version/config/prompts as you go and compiles the GUIDE-LLM reporting checklist. Writes `.mstack/llm-usage.jsonl` + `.mstack/llm-checklist.md`. |
| `/mstack:learn` | Per-paper conventions Claude should remember. Writes `.mstack/learnings.jsonl`. |
| `/mstack:mstack-upgrade` | Update MStack (git pull for clone installs; `/plugin marketplace update` for marketplace installs). |

## Reference library

The skills carry their procedures; the substance a strong methodologist brings lives in `references/`, loaded by the skills that need it at the stage that needs it.

| Reference | What it holds | Loaded by |
|---|---|---|
| `identification-threats.md` | Threats, falsification tests, and sensitivity tools by design: experiments, DiD / event study, RD, IV, shift-share, selection on observables, panel FE, cross-section, dyadic, text-as-data, case-based | identification-review, design-research, analyze, robustness, referee-mock (methodologist) |
| `estimation-conventions.md` | Estimators, standard errors, interactions, nonlinear models, tables, by design | analyze, results-audit |
| `robustness-protocols.md` | The three robustness questions, the choice inventory with its bins, specification curves, sensitivity sentences, placebos, influence | robustness, preregister |
| `polisci-data-sources.md` | Identifier schemes, canonical datasets and their pitfalls, sentinel codes, vintages, the harmonization checklist | data-acquire, data-clean, referee-mock (area-expert) |
| `audit-catalog.md` | The bugs that get papers corrected, with detection snippets | results-audit |
| `figure-conventions.md` | Figure by claim, construction rules, what referees fault | viz |
| `preregistration-guide.md` | The two-researchers standard, registries, vague-to-specific examples, secondary-data blinding | preregister, hypothesis-design |
| `writing-conventions.md` | What each section owes the reader; reporting rules; referee complaints by section | draft-section, coauthor-review, referee-mock (editor) |
| `journals.md` | Candidate journals by subfield and the fit signals to score | journal-fit |
| `survey-design-conventions.md` | Wording, order, checks placement, vignettes, conjoints, sampling, data capture | survey-build |
| `survey-bot-defenses.md` | Layered agent/bot defenses and the probe manifest (fallback for `agent-disclosure`) | survey-build |
| `referee-report-conventions.md` | Report structure and tone (fallback for `voice.reviewer_style`) | referee-mock |
| `r-conventions.md` | R style and script structure (fallback for `r-coding-skills`) | data-clean, analyze, robustness, viz |
| `pdf-extraction.md` | PDF backends and the quality gate | pdf-ingest |

Assets: `skills/preregister/assets/prereg-template.md` (the nine-section plan with estimand, SESOI, and decision rule per hypothesis), `skills/archive/assets/replication-README-template.md` (Data and Code Availability Standard layout), plus the R templates for power, codebook, specification curves, and figures.

## File output conventions

Every skill writes to predictable paths inside the paper folder:

| Skill | Writes to |
|---|---|
| `/mstack:draft-section <name>` | `paper/sections/<name>.tex` |
| `/mstack:abstract-shotgun` | `paper/sections/abstract.tex` (4–6 variants in comments, pick one) |
| `/mstack:preregister` | `prereg/osf-prereg.md` |
| `/mstack:data-clean` | `data/clean/analytic.rds` (via `code/01-clean.R`) |
| `/mstack:codebook` | `data/codebook.md` |
| `/mstack:analyze` | `output/tables/*.tex` (via `code/02-analyze.R`, `code/04-tables.R`) |
| `/mstack:viz` | `output/figures/*.{pdf,png}` (via `code/03-figures.R`) |
| `/mstack:results-audit` | `.mstack/results-audit-<date>.md` |
| `/mstack:llm-checklist` | `.mstack/llm-usage.jsonl` (ledger) + `.mstack/llm-checklist.md` (+ optional `paper/sections/llm-checklist.tex`) |
| `/mstack:coauthor-review` | `.mstack/referee-cache/coauthor-<persona>-<date>.md` |
| `/mstack:referee-mock` | `.mstack/referee-cache/referee-mock-<date>.md` |
| `/mstack:cover-letter` | `submission/cover-letter.md` |
| `/mstack:r-and-r` | `submission/response-to-reviewers/r1-response.md` (etc.) |
| `/mstack:retro` | `.mstack/retro.md` |
| `/mstack:archive` | extends `README.md` + adds `replication-manifest.txt` |
| `/mstack:submission-pack` | `submission/<journal>/` bundle + `submission/submission-checklist-<date>.md` + `paper/title-page.tex` |
| `/mstack:mstack-init <name>` | the whole `./<name>/` scaffold |

Stage-completing skills also advance `paper.status` in `.mstack/config.yaml` (`lit-map` → mapping, `design-research` → designing, `data-acquire` → building, `analyze` → analyzing, `draft-section` → writing, `r-and-r` → r-and-r, `archive` → archived), which is what `/mstack:paper-status` reconciles against the artifacts on disk.
