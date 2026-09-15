# PDF extraction for academic work

Background for `/mstack:pdf-ingest` and `bin/mstack-pdf2md`: which backend to
install, how the quality gate decides, and where the token figures come from.

## Why convert at all

A PDF handed to a model is not text. Page images are processed alongside
whatever text layer exists, so cost scales with pages rather than with words,
and the model sees a two-column article in whatever reading order the extractor
guessed. Converting first buys three things, in ascending order of importance:

1. **Fewer tokens.** Typically a 60–80% reduction on a born-digital article.
2. **Better reading order.** A layout-aware backend resolves columns, footnotes,
   and running heads once, at conversion time, instead of leaving the model to
   infer them on every read.
3. **Addressability.** Markdown has a heading spine. A skill can read
   `## 4. Empirical Strategy` from one paper instead of the whole corpus. On a
   literature of any size this matters more than the raw token count, because
   it is the difference between a corpus that fits and one that does not.

## The backends

`mstack-pdf2md --doctor` reports what is installed. `auto` starts at the
cheapest tier and climbs only when the quality gate is unhappy, so installing a
heavy backend costs nothing on documents that do not need it.

| Backend | Tier | OCR | Install | Use it for |
|---|---|---|---|---|
| `pymupdf4llm` | fast | no | `pip install pymupdf4llm` | The default. Born-digital articles, working papers, most of a normal library. Fast and small. |
| `pdftotext` | fast | no | poppler-utils | Already on many Linux boxes. `-layout` keeps columns visually but leaves the gutter in the text. |
| `docling` | layout | yes | `pip install docling` | Scans, dense tables, anything `pymupdf4llm` mangles. IBM's converter; routes tables through a structure model. |
| `marker` | heavy | yes | `pip install marker-pdf` | Highest general fidelity, including equations. Slow; wants a GPU to be pleasant. |
| `mineru` | heavy | yes | `pip install mineru` | Complex layouts and CJK, where it is materially better than the alternatives. |
| `builtin` | fallback | no | none | A zero-dependency reader using only `zlib`. No font tables, no layout model: it exists so a locked-down machine gets *something*, and it scores itself honestly low. |

A reasonable default for a social scientist: install `pymupdf4llm`, add
`docling` the first time a scan shows up.

## The quality gate

Every extraction is scored 0–1 before it is written. Below `--quality-min`
(default 0.70) the converter tries the next backend up and keeps whichever
result scored best. The defects it looks for:

| Defect | Signal | What it usually means |
|---|---|---|
| `no-text-layer` | the PDF's own text layer is under 100 chars/page | A scan. No text backend will ever help; OCR or read it natively. |
| `truncated` / `lossy` | extracted text is far shorter than the PDF's text layer | The backend silently dropped content. **The dangerous one** — output still reads fine. |
| `interleaved text` | orphaned single letters ("the fis c al capacity") | Columns diced into each other; reading order is scrambled. |
| `cid-fonts` | literal `(cid:NNN)` in the output | Subset fonts with no usable encoding. Needs OCR. |
| `garbled` / `noisy` | low ratio of alphabetic characters | Binary or table junk leaked into the text. |
| `run-on words` | many tokens over 22 characters | Inter-word spacing lost. |
| `column gutter` | runs of 4+ spaces inside lines | A layout-preserving dump; harmless but worth reflowing. |
| `sparse` / `thin` | few characters per page | A scan, a slide deck, or a failed parse. |

Two deliberate non-defects, both of which earlier drafts got wrong:

- **Long lines are fine.** A Markdown backend puts each paragraph on one line.
  Penalizing that flags the best output as the worst.
- **A missing reference list is fine.** The pipeline removes it on purpose, so
  the coverage check allows generous slack before calling an extraction lossy.

## What the pipeline does to the text

In order: normalize ligatures and quotes → rejoin words hyphenated across a line
break → strip running heads and page numbers (lines repeating on ≥40% of pages)
→ normalize headings to `##` and demote table/figure captions out of the heading
spine → rejoin paragraphs torn across a column break → split the reference list
into `<citekey>.refs.md`, one entry per block.

Splitting references out is worth calling out: a reference list is commonly a
quarter to a third of an article's text and is almost never what you need while
reading the argument. It stays available in a sibling file.

## Metadata

In priority order: the PDF's embedded metadata, then the largest type on page 1
(this survives a title that wraps onto a second line), then the first
substantial line. A DOI or arXiv id found on the front page is resolved against
Crossref or arXiv for authoritative fields; `--no-network` skips this.

Anything not confirmed by Crossref or arXiv is marked `metadata_source:
"parsed"` in the front matter and gets a `% TODO verify` comment in the staged
BibTeX. Treat those as hypotheses about a citation, not citations. When the
converter cannot find a plausible title or author it writes neither, and falls
back to the filename for the citekey — an empty field is a better prompt to fix
it than a confident wrong one.

## The token figures are estimates

Both numbers reported per document are heuristics, not tokenizer output:

- `est_tokens` — characters ÷ 4, the usual rough ratio for English prose.
- `est_tokens_as_pdf` — pages × 1,800 + text-layer characters ÷ 4.

The per-page constant stands in for rasterizing a page; real cost varies with
page size and with how a given model handles PDFs. Use the figures to compare
before and after, and to decide what to open — not to bill anyone. Say they are
estimates whenever you report them.

## Sources

The backend comparison reflects published benchmarks and tool documentation as
of 2026; see the [pdf-to-markdown benchmark](https://github.com/pdfmarkdownapp/pdf-to-markdown-benchmark)
for scored comparisons across tools, and [Docling's paper](https://arxiv.org/abs/2501.17887)
for that toolkit's approach. Steven Denney's
[Pixels and Patterns](https://www.pixelsandpatterns.org/) covers AI-assisted
social science workflow more broadly and is worth following for this kind of
plumbing.
