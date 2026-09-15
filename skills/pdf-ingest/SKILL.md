---
name: pdf-ingest
description: Convert a pile of academic PDFs into token-cheap, section-addressable Markdown with citation front matter, a corpus index, and staged BibTeX. Use when the user drops PDFs into a project, asks to read or summarize papers, says reading the literature is burning context, or before /mstack:lit-map so the map runs against text instead of scans.
argument-hint: "[path to a PDF or folder of PDFs]"
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# /mstack:pdf-ingest

**Stage:** map
**Voice:** archivist

## When to invoke

When PDFs are the input to the next piece of work. A journal PDF handed straight
to a model is the most expensive way to read a paper: every page is rendered as
an image on top of whatever text gets extracted, so a 40-page article can cost
tens of thousands of tokens before anyone has read a word. Forty of them will
not fit in a context window at all.

Converted first, the same corpus is roughly a fifth of the size, and — the part
that matters more — it becomes **addressable**. A skill can read one paper's
methods section instead of the whole paper, and can triage sixty papers from a
single index file without opening any of them.

Invoke before `/mstack:lit-map` whenever the literature is sitting on disk as
PDFs. Invoke again whenever new PDFs arrive; conversion is incremental.

## The layout this skill assumes

```
lit/
  pdf/                  source PDFs — read-only after ingestion, like data/raw/
  md/                   one <citekey>.md per paper, plus <citekey>.refs.md
  index.md              the triage table: metadata, abstracts, token costs
  refs-ingested.bib     staged BibTeX, for merging into paper/refs.bib
  .mstack-pdf2md.json   conversion cache (sha256 -> result); do not hand-edit
```

`/mstack:mstack-init` creates `lit/pdf/` and `lit/md/`. In a folder that
predates them, create them before converting.

## Procedure

1. **Locate the PDFs.** Use `$ARGUMENTS` if given; otherwise look in `lit/pdf/`,
   then ask. If the PDFs live outside the project (a Zotero storage folder, a
   Downloads directory), **copy** them into `lit/pdf/` rather than converting in
   place — the provenance rule is the same one `data/raw/` follows, and a
   reference to a file the project does not own will rot.

2. **Check the toolchain once.**

   ```bash
   python3 "${CLAUDE_PLUGIN_ROOT}/bin/mstack-pdf2md" --doctor
   ```

   This reports which extraction backends are installed. If only `builtin` is
   available, say so and recommend `pip install pymupdf4llm` (fast, ~30 MB,
   handles most born-digital articles). Recommend `pip install docling` as well
   when the pile contains scans. Do not install anything without asking.

3. **Convert.**

   ```bash
   python3 "${CLAUDE_PLUGIN_ROOT}/bin/mstack-pdf2md" lit/pdf
   ```

   Conversion is cached by file hash, so re-running only touches new or changed
   PDFs. Useful flags:

   | Flag | Use when |
   |---|---|
   | `--no-network` | Air-gapped, or the user does not want Crossref lookups |
   | `--mailto you@example.edu` | Opt into Crossref's polite pool (faster, kinder) |
   | `--backend docling` | Force a layout backend for a stubborn document |
   | `--keep-refs` | The reference list itself is the object of study |
   | `--force` | Re-convert after installing a better backend |
   | `--json` | You want the summary as data rather than prose |

4. **Read the report, not the papers.** The command prints a per-document
   quality score and flags anything that needs attention. Then read
   `lit/index.md` — that one file is the corpus.

5. **Triage what failed.** Every document is written with a `status`:

   - **`ok`** — nothing to do.
   - **`low-quality`** — extraction succeeded but the score is below threshold.
     Read the `defects` list in the file's front matter. `truncated` or
     `interleaved text` usually means a heavier backend is needed: re-run that
     one file with `--backend docling --force`.
   - **`needs-ocr`** — the PDF is a scan with no text layer. No text backend
     will ever help. Either install an OCR-capable backend (`docling`,
     `marker`, `mineru`) and re-run, or read that PDF natively yourself and
     write `lit/md/<citekey>.md` by hand in the same shape as the others.
   - **`failed`** — the file is encrypted, corrupt, or not really a PDF. Say so
     and move on; do not silently leave a broken entry in the index.

6. **Fix the metadata that matters.** Parsed metadata is a guess whenever
   `metadata_source: "parsed"` (rather than `crossref` or `arxiv`). For the
   papers that will actually be cited, check `title`, `authors`, and `year`
   against the first page and correct the front matter. A wrong citekey
   propagates into `refs.bib` and then into the manuscript.

7. **Stage the citations.** `lit/refs-ingested.bib` holds a BibTeX entry per
   document. Entries carrying a `% TODO verify` comment were parsed from the
   PDF rather than fetched from Crossref. Merge verified entries into
   `paper/refs.bib`, deduping by key. Never merge an unverified entry — the
   same rule `/mstack:lit-map` applies to invented citations.

8. **Report.** Give the user: how many documents converted, the corpus token
   cost before and after, anything flagged, and the next skill to run.

## Reading the corpus afterwards

Say this out loud when handing off, because it is the whole point of the
conversion and it is easy to forget:

- **Triage from `lit/index.md`.** It carries every paper's metadata, abstract,
  and token cost. Sixty papers cost a few thousand tokens to survey here.
- **Open one paper only when the index is not enough.**
- **Open one section when the paper is not needed whole.** The `sections` list
  in the front matter is the map; section headings are normalized to `##`, so
  `sed -n '/^## 4\./,/^## /p' lit/md/key.md` pulls a single section.
- **Leave the reference lists alone.** They are split into `<citekey>.refs.md`
  precisely so they stop costing anything on every read. Open one only to chase
  a citation.

## Outputs

- `lit/md/<citekey>.md` — one per document, with YAML front matter carrying
  citekey, title, authors, year, container, DOI/arXiv, source PDF and its
  hash, backend, quality score, status, section list, and token accounting.
- `lit/md/<citekey>.refs.md` — the reference list, one entry per block.
- `lit/index.md` — the corpus triage table plus abstracts.
- `lit/refs-ingested.bib` — staged BibTeX.
- A summary to the user: counts, token savings, flagged documents, next step.

## Anti-patterns to refuse

- **Reading the PDFs directly when conversion would work.** That is the cost
  this skill exists to remove. The exception is a `needs-ocr` document with no
  OCR backend installed — then reading it natively is the fallback, not the
  default.
- **Converting in place from outside the project.** Copy into `lit/pdf/` first,
  or the corpus is not reproducible.
- **Editing files in `lit/pdf/`.** Source PDFs are raw inputs and the guard hook
  enforces it. Corrections belong in the Markdown.
- **Merging unverified BibTeX into `paper/refs.bib`.** A parsed entry is a
  hypothesis about a citation.
- **Reporting a token saving without saying it is an estimate.** The figures
  come from a character heuristic and a per-page constant, not from a tokenizer.
- **Silently accepting a `low-quality` document.** A truncated extraction reads
  perfectly well and is missing half the paper. Escalate the backend or say
  plainly that the text is partial.
- **Deleting the source PDF after conversion.** The Markdown is a derivative;
  the PDF is the record, and page numbers for quotations come from it.

## When to call other skills

- After ingesting: `/mstack:lit-map` — it reads `lit/index.md` first and will
  engage the converted text instead of searching the web blind.
- `/mstack:theory-build` and `/mstack:draft-section` read the converted sections
  when they need a paper's actual argument.
- `/mstack:archive` should include `lit/index.md` and `lit/refs-ingested.bib`;
  whether the PDFs themselves ship depends on redistribution rights, which are
  usually not yours.
