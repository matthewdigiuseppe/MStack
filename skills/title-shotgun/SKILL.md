---
name: title-shotgun
description: Generates 8-12 title candidates across forms (declarative, question, colon, anomaly, mechanism), scores hook x precision x searchability, and pairs the winner with the abstract framing. Use late in writing when the user asks for title ideas or a better title.
allowed-tools:
  - Bash(date *)
  - Read
  - Write
  - Edit
---

# /mstack:title-shotgun

**Stage:** write · **Voice:** writer

After `/mstack:abstract-shotgun` settles a framing; editors and search engines read title and abstract together, so pair them deliberately.

## Procedure

1. **Load** `paper/sections/abstract.tex` and `.mstack/config.yaml` (journals favor different title styles).
2. **Generate 8–12 candidates** across forms:

   | Form | Example |
   |---|---|
   | Declarative | "Trade Exposure Raises Protectionist Voting" |
   | Question | "Does Trade Exposure Raise Protectionist Voting?" |
   | Colon (general: specific) | "Threats to Trade: How Import Competition Reshapes Voting in Three Democracies" |
   | Anomaly | "When the Losers Win: Compensation and Backlash in the Globalization Era" |
   | Mechanism | "Compensation Without Trust: Why Aid to the Trade-Exposed Doesn't Move Votes" |
   | Quote | "'Bring the Jobs Back': Industrial Decline and Electoral Realignment" |
   | Number-led | "Three Decades of Trade Shocks and the New Politics of Protection" |
   | Single noun phrase | "The Protectionist Turn" |

3. **Score 1–5** on hook (would a reader stop scrolling?), precision (does it convey the claim?), searchability (would the right reader find it by keyword?).
4. **Filter:** drop any title with a 1 in any dimension; rank by `hook × precision × searchability`; surface the top 3.
5. **Recommend one**, paired with the abstract framing: finding-first pairs with declarative, puzzle-first with a question or anomaly title.
6. **Save** to `.mstack/title-shotgun-<YYYY-MM-DD>.md`.

## Outputs

- `.mstack/title-shotgun-<date>.md` — candidates, scores, recommendation.
- Summary block: top 3 with scores + recommendation.

## Anti-patterns

- **Clever but vague.** Two readings to parse fails hook and precision.
- **Variables in the title.** "Effect of X on Y in Z" is a placeholder.
- **Subtitle longer than title.** Reverse the colon.

## Next

`/mstack:journal-fit` to confirm the pair suits the target journal's style.
