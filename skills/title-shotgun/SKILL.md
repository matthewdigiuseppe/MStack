---
name: title-shotgun
description: Generates 8–12 title options ranked on hook strength × precision × searchability. Use late in the writing stage, after the abstract is settled.
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Edit
---

# /mstack:title-shotgun

**Stage:** write
**Voice:** writer

## When to invoke

After `/abstract-shotgun` settles a framing. The title and abstract are read together by editors and search engines; pair them deliberately.

## Procedure

1. **Load.** `paper/sections/abstract.tex`, `.mstack/config.yaml` (target journals — different journals favor different title styles).

2. **Generate 8–12 candidates** mixing forms:

   | Form | Example |
   |---|---|
   | Declarative | "Trade Exposure Raises Protectionist Voting" |
   | Question | "Does Trade Exposure Raise Protectionist Voting?" |
   | Colon construction (general:specific) | "Threats to Trade: How Import Competition Reshapes Voting in Three Democracies" |
   | Anomaly framing | "When the Losers Win: Compensation and Backlash in the Globalization Era" |
   | Mechanism framing | "Compensation Without Trust: Why Aid to the Trade-Exposed Doesn't Move Votes" |
   | Quote framing | "'Bring the Jobs Back': Industrial Decline and Electoral Realignment" |
   | Number-led | "Three Decades of Trade Shocks and the New Politics of Protection" |
   | Single-noun-phrase | "The Protectionist Turn" |

3. **Score each candidate on three dimensions** (1–5):

   - **Hook** — would a reader stop scrolling?
   - **Precision** — does the title accurately convey the claim?
   - **Searchability** — would the right reader find this via a keyword search?

4. **Filter.** Drop any title with a 1 in any dimension. Compute `hook × precision × searchability`. Surface the top 3.

5. **Recommend one.** Tie hook-strength to the chosen abstract framing — a finding-first abstract pairs with a declarative title; a puzzle-first abstract pairs with a question or anomaly title.

6. **Save** options + scores + recommendation to `.mstack/title-shotgun-<YYYY-MM-DD>.md`.

## Outputs

- `.mstack/title-shotgun-<date>.md` — candidates, scores, recommendation.
- Summary block: top 3 with scores + recommendation.

## Anti-patterns to refuse

- **Clever-but-vague.** A title that takes two readings to parse fails on hook + precision.
- **Variables in the title.** "Effect of X on Y in Z" is a placeholder, not a title.
- **Sub-titles longer than titles.** Reverse the colon if so.

## When to call other skills

- Before: `/abstract-shotgun` (the abstract framing constrains good title choices).
- After: `/journal-fit` to confirm the title-abstract pair fits the target journal's style.
