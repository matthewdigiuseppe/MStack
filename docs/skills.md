# MStack skill reference

Each skill is invokable as `/<name>` once the plugin is installed. Stages match the workflow in [philosophy.md](philosophy.md).

## Stage 1 — Ideate

| Skill | Voice | Use when |
|---|---|---|
| `/research-question` | advisor | Starting a project or reconsidering one. Forcing questions about contribution, identification, feasibility, scoop risk. |
| `/scope-challenge` | adversarial-advisor | Project is sprawling. "Is this a paper or a footnote?" |
| `/idea-shotgun` | generative | You have data/topic, want 4–6 alternative angles before committing. |

## Stage 2 — Map

| Skill | Voice | Use when |
|---|---|---|
| `/lit-map` | systematic-reviewer | After a candidate question. Identifies must-cite papers and the gap. |
| `/theory-build` | theorist | After lit-map. Mechanism, DAG, scope conditions. |
| `/hypothesis-design` | methodologist | Before any analysis. Operationalized, falsifiable hypotheses. |
| `/identification-review` | methodologist | Before fielding/analyzing. Threats to inference, falsification tests. |

## Stage 3 — Design

| Skill | Voice | Use when |
|---|---|---|
| `/design-research` | design-critic | After identification-review. Picks design type, justifies trade-offs. |
| `/preregister` | preregistration-clerk | Before data collection or analysis. OSF/AsPredicted draft. |
| `/power-analysis` | methodologist | Before fielding. Sample size + MDE in R. |
| `/survey-build` | survey-designer | Designing a survey. Wraps `agent-disclosure` for bot defense. |

## Stage 4 — Build

| Skill | Voice | Use when |
|---|---|---|
| `/data-acquire` | data-engineer | Start of empirical work. Provenance log for every variable. |
| `/data-clean` | data-engineer | raw → clean. Wraps `r-coding-skills`. |
| `/codebook` | data-engineer | After data-clean stabilizes. Auto-doc + flags suspicious vars. |

## Stage 5 — Analyze

| Skill | Voice | Use when |
|---|---|---|
| `/analyze` | analyst | After codebook is stable. Main models + tables. |
| `/robustness` | skeptical-analyst | After main results. Robustness matrix to fight cherry-picking. |
| `/viz` | figure-designer | Results stable. Pub-quality figures. |
| `/results-audit` | staff-statistician | Before writing. Catches off-by-one, sample mismatches, p-hacking. |

## Stage 6 — Write

| Skill | Voice | Use when |
|---|---|---|
| `/draft-section <name>` | writer | Drafting any section. Wraps `digiuseppe-writing-style`. |
| `/abstract-shotgun` | writer | After complete draft. 4–6 abstract variants with positioning differences. |
| `/title-shotgun` | writer | Late-stage. Title options ranked on hook × precision. |
| `/coauthor-review` | coauthor | On a complete draft. Configurable persona. |
| `/referee-mock` | referee | Before submission. Wraps `journal-reviewer-style`. |

## Stage 7 — Submit

| Skill | Voice | Use when |
|---|---|---|
| `/journal-fit` | editor | Submission-ready. 3 target journals + comparison table. |
| `/cover-letter` | editor | After journal-fit. Drafts cover letter. |
| `/r-and-r` | editor | During R&R. Response-to-reviewers with change log. |

## Stage 8 — Reflect

| Skill | Voice | Use when |
|---|---|---|
| `/retro` | coach | After acceptance or rejection. What took longest, what to systematize. |
| `/archive` | replicator | At acceptance. Replication package + OSF/Dataverse prep. |

## Power tools

| Skill | Use when |
|---|---|
| `/careful` | Near a deadline. Warn before destructive commands. |
| `/freeze` | Lock edits to one directory. |
| `/guard` | `/careful` + `/freeze`. |
| `/unfreeze` | Remove the lock. |
| `/learn` | Per-paper conventions Claude should remember. Writes `.mstack/learnings.jsonl`. |
| `/mstack-upgrade` | Pull latest MStack from GitHub. |

## File output conventions

Every skill writes to predictable paths inside the paper folder:

| Skill | Writes to |
|---|---|
| `/draft-section <name>` | `paper/sections/<name>.tex` |
| `/abstract-shotgun` | `paper/sections/abstract.tex` (4–6 variants in comments, pick one) |
| `/preregister` | `prereg/osf-prereg.md` |
| `/data-clean` | `data/clean/analytic.rds` (via `code/01-clean.R`) |
| `/codebook` | `data/codebook.md` |
| `/analyze` | `output/tables/*.tex` (via `code/02-analyze.R`, `code/04-tables.R`) |
| `/viz` | `output/figures/*.{pdf,png}` (via `code/03-figures.R`) |
| `/results-audit` | `.mstack/audits/<date>-results-audit.md` |
| `/coauthor-review` | `.mstack/referee-cache/coauthor-<persona>-<date>.md` |
| `/referee-mock` | `.mstack/referee-cache/referee-mock-<date>.md` |
| `/cover-letter` | `submission/cover-letter.md` |
| `/r-and-r` | `submission/response-to-reviewers/r1-response.md` (etc.) |
| `/retro` | `.mstack/retro.md` |
| `/archive` | extends `README.md` + adds `replication-manifest.txt` |
