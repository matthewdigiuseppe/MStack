---
name: llm-checklist
description: Logs LLM-as-research-instrument use to a running ledger and compiles the GUIDE-LLM reporting checklist (Feuerriegel et al. 2026, Nature Human Behaviour) for your methods/SI. Use whenever an LLM is integral to the research design — text annotation/classification, simulated participants or in-silico experiments, stimulus generation, data extraction, or participant-facing chatbots — not for purely editorial drafting. Log model name/version, access mode, config, and prompts as you go (because versions and access change without notice), then compile the 14-item checklist and flag every missing item before submission.
argument-hint: "[log <details>|status|report|latex]"
allowed-tools:
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - Bash(date *)
---

# /mstack:llm-checklist

**Stage:** cross-cutting (build → submit) · reproducibility
**Voice:** reporting-clerk

Implements **GUIDE-LLM** — the consensus reporting checklist for large language models in behavioural and social science (Feuerriegel, S. et al. *A reporting checklist for large language models in behavioural science.* Nature Human Behaviour, 2026. https://doi.org/10.1038/s41562-026-02492-7). Two jobs: **log** LLM use as it happens, and **compile** the filled checklist for the paper.

## When to invoke

Invoke `log` the **first time an LLM touches the research and every time the model, version, prompt, or configuration changes** — not at write-up. The checklist demands the exact model version (often a timestamp like `gpt-4o-2024-11-20`), access mode, and configuration; these change or get discontinued without notice, so the only reliable record is one captured at the moment you ran the calls.

Invoke `report` (or `status`) when drafting methods/SI or before submission.

### The integral-vs-editorial decision rule

GUIDE-LLM targets cases where **LLM use is integral to the research design**, not minor editorial uses. Apply this rule before logging:

- **Log it** when the LLM is a research instrument or participant:
  - text annotation, classification, sentiment/stance/emotion coding, moral-language detection;
  - simulated participants, in-silico experiments, synthetic respondents;
  - generating or selecting stimuli, vignettes, or treatments;
  - extracting variables from documents that enter the analysis;
  - a participant-facing chatbot (intervention, teaching, persuasion).
- **Do not log it here** (disclose per the journal's AI-use policy instead) when the LLM only helped *write*: drafting prose, formatting tables, debugging code, brainstorming. That includes Claude/MStack itself acting as a writing aid.
- **Gray zone:** if Claude (via MStack) is used to *code or annotate study data*, or to *simulate respondents*, that is integral — log it. Drafting the discussion section is not.

When in doubt, log it: over-disclosure costs a table row, under-disclosure costs reproducibility.

## Arguments

`$ARGUMENTS` selects a subcommand:

- `log [free text or details]` — append or update one **LLM task** in the ledger. Free-form is fine; this skill normalizes it and asks for any missing checklist-critical field.
- `status` — coverage report: which of the 14 required items are filled per task, which are missing, plus a scan of the codebase for LLM calls that aren't in the ledger.
- `report` — compile the GUIDE-LLM checklist from the ledger into `.mstack/llm-checklist.md` (default if no argument is given).
- `latex` — also emit a Supplementary-Information block to `paper/sections/llm-checklist.tex`.

## The ledger

`.mstack/llm-usage.jsonl` — append-only, **one JSON object per line, one LLM task per line** (a distinct model used for a distinct purpose). The paper is explicit that when multiple LLMs or steps are involved, *each is reported separately*; one task = one line = one checklist block.

Line 1 is a `_meta` header holding project-level facts (competing interests, GUIDE-LLM citation). Lines tagged `"_example": true` are illustrative and ignored by `status`/`report`.

Task schema (fields map 1:1 to checklist items — see the item list below):

```json
{
  "id": "short-stable-handle",
  "date_logged": "YYYY-MM-DD",
  "purpose": "",                                       // A.1
  "automation": "",                                    // A.2  human-in-the-loop | fully-automated (+ audit rate)
  "model": {                                           // B.1
    "name": "", "provider": "", "size": "",
    "version_or_id": "", "access_date": "", "source_url": ""
  },
  "access_mode": "",                                   // B.2  API | web | local
  "context_mode": "",                                  // B.2  chat | separate-calls
  "config": {                                          // B.3
    "temperature": null, "max_tokens": null,
    "seed": null, "n_runs": null, "other": ""
  },
  "customization": "",                                 // B.4  none | fine-tuned | RAG | tools/function-calling | ...
  "persistent_memory": false,                          // B.5
  "prompt_user_ref": "",                               // C.1  path to verbatim prompt file
  "prompt_system_ref": "",                             // C.2  path to system-instruction file
  "data_sensitivity": "",                              // D.1
  "human_validation": "",                              // E.1
  "post_processing": "",                               // E.2
  "code_ref": "",                                      // F.1  path to script/notebook for the calls
  "opt": {                                             // optional GUIDE-LLM items
    "llm_choice_justification": "", "prompt_design_rationale": "",
    "cross_model_comparison": "", "training_data_leakage": "",
    "bias_assessment": "", "transcripts_ref": "",
    "ethical_implications": "", "compute_use": ""
  },
  "notes": ""
}
```

Store prompts as **files** (e.g. `code/llm/prompts/*.txt`) and reference the path — never paraphrase a prompt into the ledger, and keep prompts out of giant JSON strings. If the system is agentic and a single verbatim prompt is impractical, point `prompt_user_ref` at the source/config that defines the interaction logic and say so in `notes` (the paper permits "the most complete documentation feasible" in that case).

## Procedure

### `log` — record or update a task

1. **Create the ledger if absent.** If `.mstack/llm-usage.jsonl` does not exist, create it with a `_meta` header (pull competing interests from `.mstack/config.yaml` authors/funding if available; otherwise leave blank and flag it).
2. **Resolve the task.** Get today's date with `date +%Y-%m-%d`. Parse the user's text into the schema. If the user names an `id` that already exists, treat this as an **update** (rewrite that task's fields) rather than a new line — re-reading and rewriting the file. Otherwise mint a short `id` from purpose + date.
3. **Fill what you can, ask for the rest.** From the text, fill every field you can. Then ask only for the **checklist-critical** fields that are still empty:
   - exact `model.version_or_id` (refuse a bare brand like "ChatGPT" or "GPT-4" — demand the dated/identified version);
   - `access_mode` + `context_mode`;
   - `config.temperature` and `n_runs` (temperature drives reproducibility; if the model doesn't expose it, record that);
   - `prompt_user_ref` (a path, not a paraphrase);
   - `human_validation` plan or result.
   Do not block on optional (`opt.*`) fields.
4. **Append (or rewrite).** Write the normalized JSON object as one line. Echo it back.
5. **Nudge the artifacts.** If `prompt_user_ref`/`code_ref` point at files that don't exist yet, remind the user to save the verbatim prompt and the call script there — the checklist (C.1, F.1) needs them and `/mstack:archive` will collect them.

### `status` — coverage gate

1. Read every non-`_meta`, non-`_example` task.
2. For each task, print a 14-row check: ✅ filled / ⚠️ missing, item code + name. Group tasks by `id`.
3. **Scan for undocumented LLM use.** Grep the project (`code/`, `*.py`, `*.R`, `*.ipynb`, `*.qmd`) for call sites — e.g. `openai`, `anthropic`, `chat.completions`, `client.messages.create`, `litellm`, `ollama`, `transformers`, `huggingface`, `gemini`, `vertexai`, `together`, `groq`. List any file that calls an LLM but isn't referenced by some task's `code_ref`, and warn that it may need a ledger entry.
4. Print the single-line verdict: `N tasks, M required items missing across them` and the exact list to fix.

### `report` — compile the checklist

1. Read the ledger + `.mstack/config.yaml`. Skip `_meta`/`_example` lines.
2. **One block per task.** First read `references/guide-llm-items.md` (in this skill's folder) for the verbatim 14 items. For each LLM task, render the full GUIDE-LLM table, filling from the task fields. Any empty required field renders as `⚠️ MISSING — <what to capture>` so the gap is visible in the draft, not silently dropped.
3. **Optional items.** Render a separate "Optional (GUIDE-LLM online)" subsection per task from `opt.*`, omitting blanks (these are genuinely optional — no ⚠️).
4. **Project-level G.1 once.** Competing interests / funding from `_meta.competing_interests` (cross-check `.mstack/config.yaml`). If blank, flag it — G.1 is required.
5. **Citation footer.** Append the GUIDE-LLM citation and a note that the template lives at https://osf.io/mv63j/.
6. Write `.mstack/llm-checklist.md`. Print the missing-item summary so the user knows what stands between them and a complete disclosure.
7. If `latex` was requested (or offer it), also write `paper/sections/llm-checklist.tex` — a `description`/`longtable` block suitable for the SI, following the skeleton in `references/guide-llm-items.md` — and tell the user to `\input` it.

## The GUIDE-LLM items

The verbatim 14 required items, the optional online items, and the LaTeX skeleton live in **`references/guide-llm-items.md`** in this skill's folder. Read that file whenever compiling `report` or `latex`; the item codes in the ledger schema above (A.1 … G.1) map 1:1 to it.

## Outputs

- `.mstack/llm-usage.jsonl` — the append-only ledger (one task per line). Created on first `log`.
- `.mstack/llm-checklist.md` — the compiled GUIDE-LLM checklist, one block per LLM task, missing items flagged.
- `paper/sections/llm-checklist.tex` — (on request) an SI-ready block to `\input`.

## Anti-patterns to refuse

- **Bare model names.** "We used ChatGPT/GPT-4" hides version, configuration, and access mode that materially change results. Demand the exact version or identifier (B.1).
- **Paraphrased prompts.** C.1 means *verbatim*. Store the prompt as a file and reference it; do not summarize it.
- **Unreported temperature / runs.** Randomness drives behaviour; "default settings" is not a record. Capture `temperature`, `seed`, `n_runs`, or state explicitly that the model exposes none.
- **No human validation.** LLMs are prompted to stand in for a construct (sentiment, stance, moral judgment); E.1 is what licenses interpreting the outputs as that construct. An unvalidated annotation pipeline is a finding waiting to be retracted.
- **Logging at write-up.** Reconstructing the version/config months later is exactly the failure GUIDE-LLM exists to prevent. Log at time of use.
- **Over-reporting editorial use.** Don't pad the checklist with "Claude helped write the intro" — that's an AI-use disclosure, not an instrument. Apply the integral-vs-editorial rule.

## When to call other skills

- **`/mstack:data-acquire`** — if LLM outputs become a dataset (annotations, simulated responses), also log their provenance there; cross-reference the `code_ref`.
- **`/mstack:preregister`** — when LLM use is confirmatory, pre-commit the prompts, model version, and validation plan in the prereg; this ledger then documents adherence.
- **`/mstack:survey-build`** — if simulated agents or LLM-generated stimuli enter a survey, that LLM use is integral — log it here too.
- **`/mstack:draft-section methods`** — paste the compiled block (or `\input` the `.tex`) into methods/SI.
- **`/mstack:archive`** — the ledger, the prompt files, and the call scripts must all enter the replication package; `/mstack:archive` should collect every `prompt_user_ref` and `code_ref`.
- **`/mstack:learn`** — if a convention generalizes (e.g. "always log model version on the day of the run"), record it.

---

*GUIDE-LLM: Feuerriegel, S., Barrie, C., Crockett, M. J., et al. (2026). A reporting checklist for large language models in behavioural science. **Nature Human Behaviour.** https://doi.org/10.1038/s41562-026-02492-7. Checklist template: https://osf.io/mv63j/.*
