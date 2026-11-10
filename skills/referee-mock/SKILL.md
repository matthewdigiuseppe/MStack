---
name: referee-mock
description: Mock referee panel for a chosen journal — asks which journal first, tests whether a cold reader comes away with the paper's claim, profiles five reviewer types drawn from that journal's actual pool and tailored to the paper, writes each one's report (summary, a capped list of major comments each tagged by what it does to the claim, honest recommendation), then an editor's synthesis with a short fix list ranked by consequence for the claim and the likely decision. Use when a draft is near submission-ready or the user asks how reviewers at a journal will react.
argument-hint: "[journal] [R1,R3 | fresh] [minor]"
allowed-tools:
  - Read
  - Write
  - Agent
  - Bash(date *)
  - Bash(git rev-parse *)
  - Glob
  - Grep
  - WebSearch
  - WebFetch
---

# /mstack:referee-mock

**Stage:** write (pre-submission) · **Voice:** referee panel, anchored to `voice.reviewer_style` in `.mstack/config.yaml`

When every section exists and the draft is "submission-ready": the last line of defense before real reviewers. Who referees a paper depends on where it is sent, so the journal comes first and the panel is drawn from it. The panel is judged by whether it finds what would stop the claim from being believed or from mattering, not by how much it finds.

`$ARGUMENTS`: the journal (name or common abbreviation), optionally followed by `R1`–`R5` (comma-separated) to re-run only those reviewers from the saved panel, or `fresh` to redraw the panel, and `minor` to add minor comments, which are otherwise left out.

## Procedure

1. **Journal first.** If `$ARGUMENTS` names a journal, use it. Otherwise, before loading anything else, ask "Which journal should the reviewer pool come from?", offering `target_journals` from `.mstack/config.yaml` in tier order as choices, and stop until the user answers. Resolve abbreviations to the full name (JOP → *The Journal of Politics*) and state it in the report header.
2. **Comprehension test, before any memo is opened.** Spawn a fresh subagent (the Agent tool, general-purpose, not a fork) that is given only `paper/main.tex` (or `main.qmd`) and `paper/sections/`, is told to open nothing under `.mstack/`, and returns exactly: the paper's main claim in one sentence; the evidence it rests on in one sentence; why it matters and to whom in one sentence; the sentence in the draft that states the claim, quoted with its location; and where in the draft the claim first became clear. With no subagent tool, do this read yourself now and write the answers down before going on. Then read `.mstack/spine.md` and compare: **match** (same claim, evidence, and stake, clear by the end of the introduction), **partial** (the claim matches but the evidence or stake does not, or the claim surfaces only after the introduction), **mismatch** (a different claim, or none could be stated). A partial or mismatch is the first finding of the review: either the draft does not say what the author means, or the spine no longer describes the paper.
3. **Load** `.mstack/spine.md` (the claim every comment is weighed against), the manuscript and every file under `paper/sections/`; `output/tables/` and `output/figures/` to verify claims in the prose; `.mstack/config.yaml` (`design.type`); `.mstack/outline.md` if present (the supporting claims); `.mstack/lit-map.md` (the Foundation and Frontier papers, and the hostile reviewers named in its gap section); `.mstack/theory.md` (rival mechanisms).
4. **Read the journal's pool.** Start from the journal's family in `${CLAUDE_PLUGIN_ROOT}/references/reviewer-pools.md`, then check it against the journal itself (WebSearch / WebFetch; never trust memory): aims and scope; the current editors and board (subfields, methods, disciplines); the last two years of articles closest to this paper (their authors, designs, and the literatures they cite). Those authors and the paper's Frontier authors are who editors invite. Note the review norms that change a report: double-blind or not, typical number of reviewers, letter vs. article, replication verification.
5. **Profile five reviewers.** Reuse first: if `.mstack/referee-cache/` holds a panel for this journal and `$ARGUMENTS` does not say `fresh`, keep its five profiles verbatim so rounds are comparable (the user may have edited them; respect the edits). If `submission/response-to-reviewers/r<N>-decision.md` exists for this journal, the real reviewers fill the first slots, each profiled from their report. Otherwise draw five types that an editor at this journal would plausibly invite:
   - five distinct primary lenses: no two reviewers whose major comments would be the same list;
   - at least one **insider** from the paper's own conversation (the type who wrote a Frontier paper) and one reader **outside** that conversation but inside the journal's readership;
   - at least one **design referee**, calibrated to the journal's methods norms and to `design.type`;
   - at least one **rival** who holds the competing explanation or tradition: the reviewer the author fears;
   - weighted to this journal's pool, not a generic one: economists at an economics journal; at most one quantitative methodologist at a heterodox IPE journal unless its recent volumes say otherwise;
   - dispositions mixed as the journal's selectivity implies: at a journal accepting under 10%, at most one sympathetic reviewer.

   Each profile:

   | Field | Content |
   |---|---|
   | **R*n* — label** | Short type name: "trade economist", "OEP insider", "process-tracing skeptic" |
   | Background | Subfield, training, methods, theoretical tradition, the journals they publish in |
   | Why the editor picks them | The hook in this paper: cited literature, design, data, case |
   | Priors | What they believe before reading; what would win them over |
   | Presses hardest on | The two or three points where their lens meets the spine's claim, in this paper's terms |
   | Deal-breaker | The unresolved problem that makes them recommend reject |
   | Disposition | Sympathetic / neutral / skeptical, and the recommendation they lean toward |

   Profiles are types anchored to literatures ("works in the firm-heterogeneity trade literature cited in Section 2"), never a named scholar.
6. **Prior reports.** For a reused panel, read each reviewer's previous report in `.mstack/referee-cache/`; each new report opens with what improved since and what did not.
7. **Write five reports**, each strictly in its reviewer's lens. Voice, tone, and layout from `voice.reviewer_style` if it names an installed skill; otherwise `${CLAUDE_PLUGIN_ROOT}/references/referee-report-conventions.md`. The caps and the bearing tags below hold whichever applies. Ammunition by lens: design referees read the matching design section of `${CLAUDE_PLUGIN_ROOT}/references/identification-threats.md` and raise the unaddressed threats that would change the headline; theory and rival referees, the rival-mechanisms table in `.mstack/theory.md`; area and data specialists, the pitfalls in `${CLAUDE_PLUGIN_ROOT}/references/polisci-data-sources.md` for the sources used; outside readers, the importance objections in `${CLAUDE_PLUGIN_ROOT}/references/contribution.md` and the referee complaints table in `${CLAUDE_PLUGIN_ROOT}/references/writing-conventions.md`. Each report stands alone, as the editor reads them side by side; overlap is kept where it is real, since it is the strongest signal.
   - **Summary** (one paragraph): the claim as this reviewer reads it, and whether they believe it and care.
   - **Major comments, at most four, fewer when fewer exist.** Each opens with its bearing on the claim — **breaks** (the claim is not believed, or does not matter, until this is answered) or **narrows** (the claim survives in a smaller or weaker form: a narrower population, a weaker verb, a lower rung) — and carries the ask that would resolve it. A point that leaves the claim untouched is not a major comment. A reviewer with none says in one sentence why the claim survives their lens.
   - **Minor comments** only when `$ARGUMENTS` includes `minor`: at most five, presentation only.
   - **Recommendation**: `Reject`, `Major revisions`, `Minor revisions`, or `Accept`, consistent with the majors and the journal's bar.
8. **Editor's synthesis**, as this journal's handling editor:
   - **Desk screen**: sent out or desk-rejected, on fit, scope, contribution per page, length against the cap, and the comprehension result: an editor who cannot find the claim in the abstract and introduction does not send the paper out.
   - **What the panel does to the claim**, in one sentence: stands, stands narrowed (how), or not yet believed (why).
   - **Fix list, at most five**: every `breaks` issue before any `narrows`; within a tier, by the number of reviewers raising it. Each with who raised it and the ask.
   - **Leave alone**: asks that would cost time without changing whether the claim is believed or how far it reaches, one line each, so the revision does not chase them.
   - **Contested issues**: where reviewers disagree, and which way the editor leans.
   - **Swing and veto**: the reviewer whose report decides the outcome, and the one most likely to sink it.
   - **Likely decision** and its range over plausible draws of two to four reviewers from the five (as many as the journal typically uses): best draw, worst draw, most likely.
9. **Save** to `.mstack/referee-cache/referee-mock-<journal-slug>-<YYYY-MM-DD>.md` (slug: lowercase abbreviation, e.g. `io`, `jop`): header (journal, round, draft commit hash via `git rev-parse --short HEAD` or word count, date, a `Panel recommendation:` line carrying the likely decision, and a `Comprehension: match | partial | mismatch` line followed by the cold reader's three sentences beside the spine's), then the five profiles, the reports, and the synthesis. When only some reviewers re-run, carry the others' reports forward marked as unchanged, so the newest file always holds the full panel.

## Outputs

- `.mstack/referee-cache/referee-mock-<journal-slug>-<date>.md`.
- Summary block: the journal; the comprehension result; what the panel does to the claim; a table of the five reviewers (type, disposition, recommendation); the fix list; the likely decision and its range; the reviewer to worry about most.

## Anti-patterns

- **Coverage as rigor.** Forty comments bury the two that decide the paper; a short report that finds the one break beats a long one that does not.
- **A comment with no bearing.** If the author could concede it and the claim would read the same, it is not a major.
- **A generic panel.** The same five reviewers for IO and AJPS means the journal was never read; redo step 4.
- **One reviewer written five times.** Five methodologists, or five lenses that raise the same majors.
- **Sycophancy.** A panel with no reject-leaning reviewer at a selective journal is wishful; a reviewer who clears the claim says why.
- **Generic comments.** "Could use more theory" is useless; cite the section, line, or table.
- **Breaking persona.** The trade economist does not critique prose style; the outside reader does not propose identification strategies.
- **Impersonation.** Types anchored to literatures, never a real scholar's name or voice.
- **Redrawing every round.** Progress is measured against the same reviewers; redraw only on `fresh`.

## Next

A comprehension partial or mismatch → `/mstack:argument-outline`, then redraft the abstract and introduction, before anything on the fix list. Then the fix list in order; if an item touches the inference, `/mstack:results-audit` and `/mstack:identification-review` before revising; if it narrows the claim, `/mstack:claim-sharpen` so the spine says so. After revising, re-run on the same journal: the panel is reused, so you see who moved. If the desk screen or the outside reader questions fit, `/mstack:journal-fit`; otherwise `/mstack:submission-pack`.
