# MStack

**A Claude Code plugin for academic research.** Inspired by [gstack](https://github.com/garrytan/gstack).

gstack's wager is that role-based slash commands beat free-form prompting because they force the right questions at the right stage. MStack applies the same wager to research: a paper has clear stages — idea, lit, theory, design, data, analysis, writing, submission, R&R — each with its own forcing questions, failure modes, and quality bar. MStack ships 38 skills that walk a paper across all of them.

Originally built for political science / international political economy work, but the spine generalizes to most quantitative social science.

## Install

MStack works in every flavor of Claude Code: the **terminal CLI**, the **Mac and Windows desktop apps**, **Claude Code on the web** (claude.ai/code), and the **VS Code and JetBrains extensions**. The steps below are the same in all of them.

### Step 1 — Add MStack to Claude Code

Open Claude Code and type these two lines, one at a time, into the chat box:

```
/plugin marketplace add matthewdigiuseppe/MStack
/plugin install mstack@mstack
```

The first line tells Claude Code where to find MStack. The second line installs it. When both are done, all 38 MStack commands — `/mstack:research-question`, `/mstack:draft-section`, and so on — are ready to use. You can see what's installed anytime by typing `/plugin`.

### Step 2 — Start a new paper

In Claude Code, type:

```
/mstack:mstack-init tariffs-aid
```

(Replace `tariffs-aid` with a short name for your paper.) Claude will create the folder with everything in the right place. Then open the file `.mstack/config.yaml` inside it and fill in your name, the paper title, and your target journals.

You're done. From here you'd typically start with `/mstack:research-question` or `/mstack:idea-shotgun`.

### Power-user alternative (optional, terminal users only)

If you live in a Mac or Linux terminal and would rather run `mstack-init` directly from the command line instead of asking Claude, you can clone MStack manually:

```bash
git clone https://github.com/matthewdigiuseppe/MStack.git ~/.claude/plugins/mstack
cd ~/.claude/plugins/mstack
./setup
```

`./setup` registers MStack with Claude Code and prints one line for you to paste into your shell config so that typing `mstack-init my-paper` in any folder will work. Skip this whole section if you already installed via `/plugin install` above — it does the same job.

## Workflow

| Stage | What you type | What happens |
|---|---|---|
| **Setup** | `/mstack:mstack-init <name>` | Scaffolds the paper folder every other skill assumes |
| **Ideate** | `/mstack:research-question` | Forcing questions about contribution, identification, feasibility, scoop risk |
| | `/mstack:scope-challenge` | Adversarial advisor: "is this a paper or a footnote?" |
| | `/mstack:idea-shotgun` | 4–6 alternative angles on the same data/question |
| **Map** | `/mstack:lit-map` | Systematic lit scan; identifies the 3–5 papers you must engage |
| | `/mstack:theory-build` | Mechanism, DAG, scope conditions |
| | `/mstack:hypothesis-design` | Operationalized, falsifiable hypotheses |
| | `/mstack:identification-review` | Methodologist voice: threats to inference |
| **Design** | `/mstack:design-research` | Picks design type (survey/experiment/quasi/obs) |
| | `/mstack:preregister` | Drafts OSF/AsPredicted preregistration |
| | `/mstack:power-analysis` | Sample size + MDE with R code |
| | `/mstack:survey-build` | Qualtrics scaffolding with bot-defense |
| **Build** | `/mstack:data-acquire` | Pulls/documents raw data with provenance log |
| | `/mstack:data-clean` | Reproducible cleaning pipeline |
| | `/mstack:codebook` | Auto-generated codebook |
| **Analyze** | `/mstack:analyze` | Main models + regression tables |
| | `/mstack:robustness` | Robustness matrix (alt specs, samples, operationalizations) |
| | `/mstack:viz` | Publication-quality figures |
| | `/mstack:results-audit` | Staff-statistician review of analysis |
| **Write** | `/mstack:draft-section <name>` | Drafts intro/theory/methods/results/discussion in voice |
| | `/mstack:abstract-shotgun` | 4–6 abstract variants |
| | `/mstack:title-shotgun` | Title options ranked on hook/precision |
| | `/mstack:coauthor-review` | Simulated coauthor critique (configurable persona) |
| | `/mstack:referee-mock` | Mock R1 referee report |
| **Submit** | `/mstack:journal-fit` | 3 target journals + comparison table |
| | `/mstack:submission-pack` | Anonymization sweep + format checks + staged upload bundle |
| | `/mstack:cover-letter` | Cover letter to journal |
| | `/mstack:r-and-r` | Response-to-reviewers with change log |
| **Reflect** | `/mstack:retro` | Paper retrospective |
| | `/mstack:archive` | Replication package + OSF/Dataverse prep |
| **Power** | `/mstack:paper-status` | Where the project stands + the one recommended next skill |
| | `/mstack:careful`, `/mstack:freeze`, `/mstack:guard`, `/mstack:unfreeze` | Edit-safety controls, enforced by a PreToolUse hook |
| | `/mstack:llm-checklist` | Log LLM-as-instrument use; compile the GUIDE-LLM reporting checklist |
| | `/mstack:learn` | Per-paper conventions Claude should remember |
| | `/mstack:mstack-upgrade` | Self-update (git or marketplace install) |

## Per-paper scaffold

`/mstack:mstack-init` creates this layout, and every skill assumes it:

```
my-paper/
  .mstack/{config.yaml, learnings.jsonl, llm-usage.jsonl, referee-cache/}
  paper/{main.tex, refs.bib, sections/}
  data/{raw/, clean/, codebook.md}
  code/{01-clean.R, 02-analyze.R, 03-figures.R, 04-tables.R}
  output/{figures/, tables/}
  submission/{cover-letter.md, response-to-reviewers/}
  prereg/osf-prereg.md
  README.md
```

## Design principles

1. **Role > prompt.** Every skill speaks in a defined voice (advisor, methodologist, referee, replicator).
2. **Forcing questions over generation.** Early-stage skills interrogate before they produce.
3. **Shotgun for divergence, review for convergence.** Generate 4–6 variants, then critique a single candidate.
4. **Per-project memory.** A `.mstack/` folder stores conventions, decisions, learnings.
5. **Catch errors before reviewers do.** Internal `/mstack:results-audit`, `/mstack:coauthor-review`, `/mstack:referee-mock` front-run journal review.
6. **Reproducibility is non-negotiable.** Replication-package and preregistration skills are first-class.
7. **Enforcement over convention.** The safety modes (`/mstack:careful`, `/mstack:freeze`) and the read-only `data/raw/` rule are backed by a `PreToolUse` hook that blocks the tool call itself — not by prompt text hoping to be remembered.

## Defaults

- **Stats stack.** R (ggplot, fixest, modelsummary). Stata/Python users: fork.
- **Manuscript format.** LaTeX. Quarto users: `mstack-init --quarto`. Word: out of scope.
- **Voice.** `/mstack:draft-section` and `/mstack:abstract-shotgun` anchor tone to whatever skill name you put in `voice.writing_style` in `.mstack/config.yaml`. MStack does not ship a personal style — install or author your own writing-style skill and point the config at it. If left empty, a generic academic voice is used.

## License

MIT.
