---
name: lit-map
description: Systematic literature scan that finds the 3-5 must-engage papers, synthesizes the consensus and where it cracks, states the gap, and stages BibTeX into paper/refs.bib. Use after a research question is locked, when the user asks what to cite or who has written on a topic, or before drafting the intro or theory.
allowed-tools:
  - Read
  - Write
  - Edit
  - WebFetch
  - WebSearch
  - Bash(date *)
---

# /mstack:lit-map

**Stage:** map
**Voice:** systematic-reviewer

## When to invoke

After `/mstack:research-question` returns a green or yellow verdict and you have a concrete claim. The lit-map exists to answer one question: **what conversation is this paper joining, and where does it crack the consensus?**

## Procedure

1. **Load context.** Read `.mstack/research-question.md` (the contribution sentence is the seed).

2. **Define the search.** Produce a one-paragraph search strategy:
   - 3–5 keyword combinations.
   - 2–3 authors whose work is most directly engaged.
   - Time window (typically last 10 years, plus the foundational older papers).
   - Venues (top-3 IPE / political science journals plus working-paper repositories like SSRN, NBER, OSF).
   Get user sign-off before searching.

3. **Search.**
   - Use WebSearch for keyword + author scans.
   - Use WebFetch (or, if available, a Google Scholar / Semantic Scholar MCP) to pull abstracts and citation counts for top hits.
   - Build a candidate set of 20–40 papers.

4. **Triage.** Classify each paper into:
   - **Foundation** (3–5): the canonical works the conversation rests on. Must-cite or you look unread.
   - **Frontier** (5–10): recent work in active conversation with the paper's claim. Engage explicitly.
   - **Adjacent** (5–10): related but on a different question. Cite once, don't engage at length.
   - **Discard** (the rest): noted in the file, not engaged.

5. **Map the consensus.** For Foundation + Frontier, produce a one-paragraph synthesis:
   - What does the consensus believe?
   - Where does it crack? What is contested?
   - What does the canonical work *not* answer?

6. **Locate the gap.** State, in one paragraph, where the user's project fits:
   - Which paper(s) does it most directly engage?
   - What does it add that they don't have?
   - Which hostile reviewer would object, and why?

7. **Stage `refs.bib` entries.** For every Foundation + Frontier paper, produce a BibTeX entry and append to `paper/refs.bib` (deduped by key). Do not invent fields — if a field (e.g., page numbers) isn't available, leave it blank with a `% TODO` comment.

8. **Save the map** to `.mstack/lit-map.md` with the full classification, synthesis, and gap statement. Set `paper.status: "mapping"` in `.mstack/config.yaml` if it still says `ideating`.

## Outputs

- `.mstack/lit-map.md` — full map with consensus + gap statement.
- `paper/refs.bib` — appended with new entries (no overwrites; dedupe by key).
- A summary block to the user: top 5 must-engage papers, the gap statement, and the suggestion to run `/mstack:identification-review` or `/mstack:theory-build` next.

## Anti-patterns to refuse

- **Skipping the synthesis step.** A list of 30 papers is not a lit map. The map is the synthesis.
- **Inventing citations.** If a paper isn't found via search, leave it out — don't fabricate.
- **Engaging too broad a frontier.** Five engaged papers > fifteen name-drops.
- **Hiding contradictions.** If the consensus contradicts the user's claim, surface it explicitly. Better here than at R1.

## When to call other skills

- Before drafting `intro` or `theory`: `/mstack:lit-map` is a prerequisite.
- After the map: `/mstack:theory-build` (sharpen mechanism), then `/mstack:hypothesis-design`.
