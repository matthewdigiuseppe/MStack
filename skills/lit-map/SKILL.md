---
name: lit-map
description: Systematic literature scan — the 3-5 must-engage papers, the consensus and where it cracks, the gap, and BibTeX staged into paper/refs.bib. Use once a research question is locked, when the user asks what to cite or who has written on a topic, or before drafting the intro or theory.
allowed-tools:
  - Read
  - Write
  - Edit
  - WebFetch
  - WebSearch
  - Bash(date *)
---

# /mstack:lit-map

**Stage:** map · **Voice:** systematic-reviewer

After `/mstack:research-question` returns green or yellow. One question: **what conversation is this paper joining, and where does it crack the consensus?**

## Procedure

1. **Load** `.mstack/research-question.md`; the contribution sentence is the seed. If `lit/index.md` exists, read it first: triaging the converted corpus costs a fraction of opening papers. If `lit/pdf/` holds unconverted PDFs, run `/mstack:pdf-ingest` before going further; searching the web for abstracts of papers you already own is backwards.
2. **Define the search** in one paragraph and get sign-off: 3–5 keyword combinations; the 2–3 most directly engaged authors; time window (typically 10 years plus the foundational older work); venues (top-3 field journals plus SSRN, NBER, OSF).
3. **Search.** Local corpus first (`lit/index.md`, then the relevant section of a converted paper rather than the whole file). WebSearch for keyword + author scans; WebFetch (or a Google Scholar / Semantic Scholar MCP if available) for abstracts and citation counts. Build 20–40 candidates.
4. **Triage** each paper: **Foundation** (3–5; the canonical works the conversation rests on; must-cite), **Frontier** (5–10; recent work in active conversation with the claim; engage explicitly), **Adjacent** (5–10; related but a different question; cite once), **Discard** (noted in the file, not engaged).
5. **Map the consensus** (Foundation + Frontier, one paragraph answering three questions):
   - What does the consensus believe?
   - Where does it crack; what is contested?
   - What does the canonical work *not* answer?
6. **Locate the gap** (one paragraph answering three questions):
   - Which paper(s) does the project most directly engage?
   - What does it add that they lack?
   - Which hostile reviewer would object, and why?
7. **Stage `refs.bib`.** A BibTeX entry per Foundation + Frontier paper, appended to `paper/refs.bib` (dedupe by key, never overwrite). Do not invent fields; leave unknowns blank with a `% TODO`. Prefer entries from `lit/refs-ingested.bib` for ingested papers, but only those without a `% TODO verify` marker (metadata parsed from the PDF rather than fetched from Crossref).
8. **Save** to `.mstack/lit-map.md`: classification, synthesis, gap. Set `paper.status: "mapping"` in `.mstack/config.yaml` if it still says `ideating`.

## Outputs

- `.mstack/lit-map.md` — map, consensus, gap statement.
- `paper/refs.bib` — appended entries.
- Summary block: top 5 must-engage papers, the gap, next skill.

## Anti-patterns

- **A list instead of a synthesis.** Thirty papers is not a map; the synthesis is.
- **Inventing citations.** Not found by search means left out.
- **Too broad a frontier.** Five engaged papers beat fifteen name-drops.
- **Hiding contradictions.** If the consensus contradicts the claim, say so now rather than at R1.

## Next

`/mstack:theory-build`, then `/mstack:hypothesis-design` and `/mstack:identification-review`. A lit map is a prerequisite for drafting `intro` or `theory`.
