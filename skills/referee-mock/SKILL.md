---
name: referee-mock
description: Mock referee panel for a chosen journal — asks which journal first, profiles five reviewer types drawn from that journal's actual pool and tailored to the paper, writes each one's report (summary, major and minor comments, honest recommendation), then an editor's synthesis of consensus issues and the likely decision. Use when a draft is near submission-ready or the user asks how reviewers at a journal will react.
argument-hint: "[journal] [R1,R3 | fresh]"
allowed-tools:
  - Read
  - Write
  - Bash(date *)
  - Bash(git rev-parse *)
  - Glob
  - Grep
  - WebSearch
  - WebFetch
---

# /mstack:referee-mock

**Stage:** write (pre-submission) · **Voice:** referee panel, anchored to `voice.reviewer_style` in `.mstack/config.yaml`

When every section exists and the draft is "submission-ready": the last line of defense before real reviewers. Who referees a paper depends on where it is sent, so the journal comes first and the panel is drawn from it.

`$ARGUMENTS`: the journal (name or common abbreviation), optionally followed by `R1`–`R5` (comma-separated) to re-run only those reviewers from the saved panel, or `fresh` to redraw the panel.

## Procedure

1. **Journal first.** If `$ARGUMENTS` names a journal, use it. Otherwise, before loading anything else, ask "Which journal should the reviewer pool come from?", offering `target_journals` from `.mstack/config.yaml` in tier order as choices, and stop until the user answers. Resolve abbreviations to the full name (JOP → *The Journal of Politics*) and state it in the report header.
2. **Load** `paper/main.tex` (or `main.qmd`) and every file under `paper/sections/`; `output/tables/` and `output/figures/` to verify claims in the prose; `.mstack/config.yaml` (`design.type`); `.mstack/lit-map.md` (the Foundation and Frontier papers, and the hostile reviewers named in its gap section); `.mstack/theory.md` (rival mechanisms).
3. **Read the journal's pool.** Start from the journal's family in `${CLAUDE_PLUGIN_ROOT}/references/reviewer-pools.md`, then check it against the journal itself (WebSearch / WebFetch; never trust memory): aims and scope; the current editors and board (subfields, methods, disciplines); the last two years of articles closest to this paper (their authors, designs, and the literatures they cite). Those authors and the paper's Frontier authors are who editors invite. Note the review norms that change a report: double-blind or not, typical number of reviewers, letter vs. article, replication verification.
4. **Profile five reviewers.** Reuse first: if `.mstack/referee-cache/` holds a panel for this journal and `$ARGUMENTS` does not say `fresh`, keep its five profiles verbatim so rounds are comparable (the user may have edited them; respect the edits). If `submission/response-to-reviewers/r<N>-decision.md` exists for this journal, the real reviewers fill the first slots, each profiled from their report. Otherwise draw five types that an editor at this journal would plausibly invite:
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
   | Presses hardest on | Three or four concrete issues, in this paper's terms |
   | Deal-breaker | The unresolved problem that makes them recommend reject |
   | Disposition | Sympathetic / neutral / skeptical, and the recommendation they lean toward |

   Profiles are types anchored to literatures ("works in the firm-heterogeneity trade literature cited in Section 2"), never a named scholar.
5. **Prior reports.** For a reused panel, read each reviewer's previous report in `.mstack/referee-cache/`; each new report opens with what improved since and what did not.
6. **Write five reports**, each strictly in its reviewer's lens. Voice, tone, and structure from `voice.reviewer_style` if it names an installed skill; otherwise `${CLAUDE_PLUGIN_ROOT}/references/referee-report-conventions.md`. Ammunition by lens: design referees read the matching design section of `${CLAUDE_PLUGIN_ROOT}/references/identification-threats.md` and raise every unaddressed threat and unreported sensitivity analysis; theory and rival referees, the rival-mechanisms table in `.mstack/theory.md`; area and data specialists, the pitfalls in `${CLAUDE_PLUGIN_ROOT}/references/polisci-data-sources.md` for the sources used; outside readers, the referee complaints table in `${CLAUDE_PLUGIN_ROOT}/references/writing-conventions.md`. Each report stands alone, as the editor reads them side by side; overlap is kept where it is real, since it is the strongest signal.
   - **Summary** (one paragraph): what the paper does and claims, as this reviewer reads it.
   - **Major comments** (2–5): issues that change the headline if unaddressed, each with the ask that would resolve it.
   - **Minor comments** (3–10).
   - **Recommendation**: `Reject`, `Major revisions`, `Minor revisions`, or `Accept`, consistent with the majors and the journal's bar.
7. **Editor's synthesis**, as this journal's handling editor:
   - **Desk screen**: sent out or desk-rejected, on fit, scope, contribution per page, and length against the cap.
   - **Consensus issues**: raised by two or more reviewers, ranked by count × severity. This is the fix list.
   - **Contested issues**: where reviewers disagree, and which way the editor leans.
   - **Swing and veto**: the reviewer whose report decides the outcome, and the one most likely to sink it.
   - **Likely decision** and its range over plausible draws of two to four reviewers from the five (as many as the journal typically uses): best draw, worst draw, most likely.
8. **Save** to `.mstack/referee-cache/referee-mock-<journal-slug>-<YYYY-MM-DD>.md` (slug: lowercase abbreviation, e.g. `io`, `jop`): header (journal, round, draft commit hash via `git rev-parse --short HEAD` or word count, date, and a `Panel recommendation:` line carrying the likely decision), then the five profiles, the reports, and the synthesis. When only some reviewers re-run, carry the others' reports forward marked as unchanged, so the newest file always holds the full panel.

## Outputs

- `.mstack/referee-cache/referee-mock-<journal-slug>-<date>.md`.
- Summary block: the journal; a table of the five reviewers (type, disposition, recommendation); the top three consensus issues; the likely decision and its range; the reviewer to worry about most.

## Anti-patterns

- **A generic panel.** The same five reviewers for IO and AJPS means the journal was never read; redo step 3.
- **One reviewer written five times.** Five methodologists, or five lenses that raise the same majors.
- **Sycophancy.** A reviewer with no major comment did not read hard enough; a panel with no reject-leaning reviewer at a selective journal is wishful.
- **Generic comments.** "Could use more theory" is useless; cite the section, line, or table.
- **Breaking persona.** The trade economist does not critique prose style; the outside reader does not propose identification strategies.
- **Impersonation.** Types anchored to literatures, never a real scholar's name or voice.
- **Redrawing every round.** Progress is measured against the same reviewers; redraw only on `fresh`.

## Next

Fix the consensus issues first; if any touch the inference, `/mstack:results-audit` and `/mstack:identification-review` before revising. After revising, re-run on the same journal: the panel is reused, so you see who moved. If the desk screen or the outside reader questions fit, `/mstack:journal-fit`; otherwise `/mstack:submission-pack`.
