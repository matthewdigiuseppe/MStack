# Political science and IPE data: identifiers, vintages, pitfalls

Read by `/mstack:data-acquire` (what to record per source),
`/mstack:data-clean` (harmonization), and `/mstack:results-audit` (the
merge and sentinel-value bugs that survive into tables). Verify current
versions and licenses on each provider's site; this file is about what
goes wrong, not a catalogue of URLs.

## Identifier systems: the merge problem

Never merge on country names. Every source uses its own identifier scheme,
and the schemes disagree on which states exist, when, and under what code.

| Scheme | Used by | Notes |
|---|---|---|
| COW `ccode` | Correlates of War, Polity, many IR datasets | Numeric; state system membership dates matter (a state-year exists only while COW counts the state as a member) |
| Gleditsch–Ward | UCDP/PRIO, many conflict datasets | Overlaps COW but differs on microstates and independence dates |
| ISO3 / ISO3n | WDI, IMF, UN Comtrade, PWT, most economics | Alpha and numeric variants; Kosovo, Taiwan, and Palestine are unstable across sources |
| V-Dem `country_id`, `country_text_id`, `COWcode` | V-Dem | Historical polities; some entities lack a COW code |
| Polity `ccode` + `scode` | Polity5 | Follows COW with exceptions (e.g. split states) |
| NUTS (EU regions) | Eurostat, ESS regional variables, Cohesion data | Revisions in 2003, 2006, 2010, 2013, 2016, 2021 change codes and boundaries; always record the NUTS version and use Eurostat correspondence tables |
| US FIPS counties, commuting zones | Census, BLS, ADH China-shock data | County changes (Virginia independent cities, Alaska boroughs, Connecticut planning regions from 2022); commuting zones follow Autor & Dorn (2013) 1990 definitions |
| Party codes: MARPOR party id, ParlGov party id, CHES party id | Manifesto Project, ParlGov, Chapel Hill Expert Survey | Crosswalks exist (ParlGov links to MARPOR and CHES); mergers and splits create one-to-many links |

Rules: use the `countrycode` package for country conversions and inspect
its warnings; keep one versioned crosswalk file per identifier pair in
`data/raw/crosswalks/`; assert unit-year uniqueness after every merge.

**State existence changes that break naive panels.** Germany (COW 255
after 1990; West Germany 260, East Germany 265 before), USSR → Russia (365)
and successor states in 1991, Yugoslavia → Serbia (345) via several
transitions, Czechoslovakia (315) → Czech Republic (316) and Slovakia (317)
in 1993, Sudan (625) → Sudan and South Sudan (626) in 2011, Ethiopia (530)
→ Ethiopia and Eritrea (531) in 1993, Vietnam (816/817) unification 1975,
Yemen (678/680 → 679) unification 1990, Pakistan (770) → Bangladesh (771)
in 1971. Check the codes against the current COW state-system list before
relying on them; the point is that rows must exist only for years the unit
existed, and never as zeros.

## Canonical datasets and their pitfalls

| Dataset | Unit | What to record | Pitfalls |
|---|---|---|---|
| V-Dem | country-year | version (annual releases), variables used with suffix (`_osp`, `_ord`, `_codelow/_codehigh`), `e_` external variables | Measurement-model uncertainty ignored; `e_` variables are imported from other sources (Polity, WDI) with their own vintages; interpolated years flagged |
| Polity5 | country-year | release year | Sentinel codes −66 (foreign interruption), −77 (interregnum), −88 (transition) are not scores; `polity2` interpolates them, `polity` does not; construct-validity critiques of the components |
| Freedom House | country-year | edition | Scale changes over time; scores reflect the previous calendar year |
| COW (state system, MIDs, wars, NMC, trade, alliances / ATOP) | state, dyad, state-year | version | Trade data missing coded as −9 in older releases; dyadic files directed vs. non-directed; NMC's CINC uses period-varying denominators |
| UCDP/PRIO Armed Conflict, UCDP GED | conflict-year, event | version, best/low/high estimate | 25- and 1,000-death thresholds define onset; "best" estimates vs. bounds; geocoded events have precision codes |
| ACLED | event | download date, country coverage start dates | Coverage starts at different years by region; fatality counts are reported, not verified |
| Global Terrorism Database | event | version | 1993 data missing; definitional changes in 2012 |
| Quality of Government (QoG) | country-year | Standard vs. Basic, version | Compiles other sources with their vintages; check the original for the variable you use |
| WDI | country-year | download date, indicator codes | Revisions between downloads; some indicators are modeled estimates; NA vs. 0 in trade and aid series |
| Penn World Table | country-year | version | Version changes revise real GDP substantially; choose `rgdpe` vs. `rgdpo` deliberately |
| IMF DOTS, IFS, WEO | country-year, dyad-year | extraction date | Mirror statistics disagree; CIF vs. FOB valuation; WEO contains forecasts |
| UN Comtrade, BACI (CEPII), WITS | dyad-product-year | HS revision, extraction date | HS revisions (1992, 1996, 2002, 2007, 2012, 2017, 2022) need concordances; BACI reconciles mirror flows; reporter vs. partner reporting |
| MARPOR / Manifesto Project | party-election | version | `rile` is contested as a left-right measure; missing party-election combinations; coding-scheme changes across versions |
| ParlGov | party, cabinet, election | release | Cabinet dates vs. election dates; caretaker cabinets |
| CHES | party-wave | wave | Waves at irregular intervals; expert-survey uncertainty |
| CSES | respondent (post-election) | module | Modules differ in items; weights by country |
| ESS | respondent (biennial) | round, edition | Design and post-stratification weights; regional variable is NUTS at varying levels by country; trust items on 0–10 scales |
| WVS / EVS | respondent (waves) | wave, integrated file version | Item wording changes across waves; country coverage varies by wave |
| Eurobarometer (GESIS) | respondent | survey number | Weights (`w1`, `w3`, ...), DK codes, trust items ask about national vs. EU institutions separately |
| ANES, Afrobarometer, LAPOP AmericasBarometer, Latinobarómetro, Arab Barometer | respondent | year/wave, file version | Negative and 9x codes for DK/refused vary by year; merged files carry harmonization decisions |
| Database of Political Institutions (DPI) | country-year | version (now IDB) | Coding conventions for executive party changed across releases |
| Chinn–Ito (KAOPEN) | country-year | version | Normalized index; updated annually |
| Laeven & Valencia crises | country-year | version | Crisis start years revised across versions |
| AidData, OECD CRS | project, donor-recipient-year | version, extraction date | Commitments vs. disbursements; deflators; CRS coverage of non-DAC donors |
| UN General Assembly votes (Bailey, Strezhnev & Voeten) | state-session | version | Ideal points vs. raw agreement; abstentions coded separately |
| Eurostat regional (NUTS-2) | region-year | NUTS version, extraction date | Boundary changes; series breaks; GDP in PPS vs. euros |
| ADH China-shock replication data; Colantone & Stanig regional exposure | CZ or region-period | replication file version | Period definitions (1990–2007), instrument built from other high-income countries' imports; do not rebuild silently |
| DESTA (trade agreements), UNCTAD BITs, WTO tariffs via WITS TRAINS | agreement, dyad-year, product | version | Signature vs. entry-into-force dates; depth indices |
| Global Sanctions Database, TIES | sanction case | version | Threatened vs. imposed; multilateral vs. unilateral coding |
| IMF MONA; Kentikelenis & Stubbs conditionality | program, condition | version | Programs vs. arrangements; conditions counted differently across sources |

## Sentinel values and missing codes

Recode to `NA` before any arithmetic, and list every recode in
`code/01-clean.R`:

- Polity: −66, −77, −88.
- COW trade and older COW files: −9.
- Survey data: negative codes (−1 inapplicable, −8 don't know, −9 refused,
  and year-specific variants), 8/9, 98/99, 998/999, 9998/9999 for DK/refused
  on scales of the corresponding width.
- WDI and Eurostat: `..` or `:` in CSV downloads read as strings.
- Aid, trade, conflict deaths: an exact zero can be "no flow", "not
  reported", or "below threshold"; check the codebook and keep a flag.
- Dates: 9999-12-31 and 1900-01-01 placeholders.

## Vintages, prices, and units

- Record the release or extraction date of every source in
  `data/raw/PROVENANCE.md`; GDP, trade, and conflict-death series are
  revised, and a rerun on a newer vintage will not reproduce the tables.
- Nominal vs. real; PPP vs. market exchange rates; deflator and base year;
  one denominator source for all per-capita variables.
- Currency units (thousands vs. millions), shares vs. percentages, and
  percentage points; annotate in the codebook.
- Fiscal vs. calendar years; election years vs. survey fieldwork years;
  "year" in a post-election survey is the election year, not the interview
  year.

## Harmonization checklist for `code/01-clean.R`

1. One crosswalk file per identifier pair, versioned and cited.
2. Sentinel values recoded to `NA` first, with the codes listed.
3. Every join asserts the expected row count and the join type; many-to-many
   joins are forbidden unless the reason is written next to them.
4. Unit-year uniqueness asserted after every join.
5. Rows exist only for unit-years the unit existed; no zero-filling
   non-existence.
6. Lags and leads computed within unit after sorting by time, and never
   across gaps (`dplyr::lag()` on an unsorted or ungrouped frame is a
   classic silent bug); assert `lag(year) == year - 1` where a lag is used.
7. Aggregation from lower units (regions to countries, districts to states)
   states the weighting (population, area, none).
8. Regional codes converted to one NUTS or FIPS version with the official
   correspondence table; series breaks flagged.
9. Labels preserved (`haven::labelled`, `labelled::var_label()`) and the
   original variable names kept in the crosswalk.
10. Sanity figures: time series of the key variables by unit, a histogram
    of treatment, a map when the data are spatial; the eye catches what
    `summary()` misses.
