# MStack

**A Claude Code plugin for academic research.** Inspired by [gstack](https://github.com/garrytan/gstack).

gstack's wager is that role-based slash commands beat free-form prompting because they force the right questions at the right stage. MStack applies the same wager to research: a paper has clear stages — idea, lit, theory, design, data, analysis, writing, submission, R&R — each with its own forcing questions, failure modes, and quality bar. MStack ships ~33 skills that walk a paper across all of them.

Originally built for political science / international political economy work, but the spine generalizes to most quantitative social science.

## Install

MStack ships as a single-plugin Claude Code marketplace. The slash-command install path works identically across the **CLI**, the **desktop app** (Mac/Windows), the **web app** at claude.ai/code, and the **IDE extensions** (VS Code, JetBrains).

### Recommended: install as a plugin (all interfaces)

In any Claude Code session, run:

```text
/plugin marketplace add matthewdigiuseppe/MStack
/plugin install mstack@mstack
```

That registers MStack's marketplace and installs the plugin. The 34 slash commands (`/research-question`, `/draft-section`, …) become available immediately. You can also browse and manage MStack from `/plugin` (Discover / Installed / Marketplaces tabs).

To scaffold a new paper folder from a Claude Code session, ask Claude to run the bundled `mstack-init` script — its path is `${CLAUDE_PLUGIN_ROOT}/bin/mstack-init <paper-name>` once the plugin is installed.

### Optional: manual install (CLI / desktop, puts `mstack-init` on shell PATH)

If you'd rather run `mstack-init` directly from your terminal without going through Claude Code, clone and run `./setup`:

```bash
git clone --single-branch --depth 1 https://github.com/matthewdigiuseppe/MStack.git ~/.claude/plugins/mstack \
  && cd ~/.claude/plugins/mstack && ./setup
```

`./setup` symlinks the plugin into `~/.claude/skills/mstack` and prints a one-line export to add `bin/` to your `PATH`. Then `mstack-init my-paper` works from any directory.

This path is for local shells only — on Claude Code on the web there is no persistent shell to add to, so use the plugin install above instead.

## Workflow

| Stage | What you type | What happens |
|---|---|---|
| **Ideate** | `/research-question` | Forcing questions about contribution, identification, feasibility, scoop risk |
| | `/scope-challenge` | Adversarial advisor: "is this a paper or a footnote?" |
| | `/idea-shotgun` | 4–6 alternative angles on the same data/question |
| **Map** | `/lit-map` | Systematic lit scan; identifies the 3–5 papers you must engage |
| | `/theory-build` | Mechanism, DAG, scope conditions |
| | `/hypothesis-design` | Operationalized, falsifiable hypotheses |
| | `/identification-review` | Methodologist voice: threats to inference |
| **Design** | `/design-research` | Picks design type (survey/experiment/quasi/obs) |
| | `/preregister` | Drafts OSF/AsPredicted preregistration |
| | `/power-analysis` | Sample size + MDE with R code |
| | `/survey-build` | Qualtrics scaffolding with bot-defense |
| **Build** | `/data-acquire` | Pulls/documents raw data with provenance log |
| | `/data-clean` | Reproducible cleaning pipeline |
| | `/codebook` | Auto-generated codebook |
| **Analyze** | `/analyze` | Main models + regression tables |
| | `/robustness` | Robustness matrix (alt specs, samples, operationalizations) |
| | `/viz` | Publication-quality figures |
| | `/results-audit` | Staff-statistician review of analysis |
| **Write** | `/draft-section <name>` | Drafts intro/theory/methods/results/discussion in voice |
| | `/abstract-shotgun` | 4–6 abstract variants |
| | `/title-shotgun` | Title options ranked on hook/precision |
| | `/coauthor-review` | Simulated coauthor critique (configurable persona) |
| | `/referee-mock` | Mock R1 referee report |
| **Submit** | `/journal-fit` | 3 target journals + comparison table |
| | `/cover-letter` | Cover letter to journal |
| | `/r-and-r` | Response-to-reviewers with change log |
| **Reflect** | `/retro` | Paper retrospective |
| | `/archive` | Replication package + OSF/Dataverse prep |
| **Power** | `/careful`, `/freeze`, `/guard`, `/unfreeze` | Edit-safety controls |
| | `/learn` | Per-paper conventions Claude should remember |
| | `/mstack-upgrade` | Self-update |

## Per-paper scaffold

`mstack-init` creates this layout, and every skill assumes it:

```
my-paper/
  .mstack/{config.yaml, learnings.jsonl, referee-cache/}
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
5. **Catch errors before reviewers do.** Internal `/results-audit`, `/coauthor-review`, `/referee-mock` front-run journal review.
6. **Reproducibility is non-negotiable.** Replication-package and preregistration skills are first-class.

## Defaults

- **Stats stack.** R (ggplot, fixest, modelsummary). Stata/Python users: fork.
- **Manuscript format.** LaTeX. Quarto users: `mstack-init --quarto`. Word: out of scope.
- **Voice.** `/draft-section` and `/abstract-shotgun` anchor tone to whatever skill name you put in `voice.writing_style` in `.mstack/config.yaml`. MStack does not ship a personal style — install or author your own writing-style skill and point the config at it. If left empty, a generic academic voice is used.

## License

MIT.
