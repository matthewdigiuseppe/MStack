#!/usr/bin/env python3
"""MStack SessionStart hook: put the paper's main idea in front of the session.

Inside an MStack paper folder (a directory tree containing .mstack/), prints
the five lines of .mstack/spine.md and the last entry of its log. Claude Code
adds a SessionStart hook's stdout to the session's context, so every session
on the paper, including one that never invokes a skill, starts from the claim
rather than from whatever file happens to be open. It runs again after
/clear and after compaction, which is when the claim would otherwise drop out
of context.

Outside a paper folder it prints nothing. It never writes, and it never
fails the session: any error exits 0 silently. Standard library only.
"""
import glob
import json
import os
import re
import sys
from pathlib import Path

FIELDS = ("Claim", "Who must change their mind", "Carried by", "Strongest rival", "Does not cover")
MAX_FIELD = 600     # characters per line of the spine; it is meant to be short
RESULT_GLOBS = (".mstack/results-audit-*.md", ".mstack/robustness-*.md")


def find_project(start):
    try:
        p = Path(start).resolve()
    except OSError:
        return None
    for candidate in [p, *p.parents]:
        if (candidate / ".mstack").is_dir():
            return candidate
    return None


def read_spine(project):
    """Return ({field: value}, last log line). Template comments are dropped."""
    try:
        text = (project / ".mstack" / "spine.md").read_text(errors="ignore")
    except OSError:
        return {}, ""
    text = re.sub(r"<!--.*?-->", "", text, flags=re.S)
    head, _, log = text.partition("\n## Log")
    fields = {}
    for name in FIELDS:
        m = re.search(r"^\s*\*\*" + re.escape(name) + r":?\*\*:?[ \t]*(.*)$", head, re.M | re.I)
        value = m.group(1).strip() if m else ""
        if value:
            fields[name] = value[:MAX_FIELD]
    entries = [l.strip() for l in log.splitlines() if l.strip().startswith("-")]
    return fields, (entries[-1].lstrip("- ").strip()[:300] if entries else "")


def title(project):
    try:
        for line in (project / ".mstack" / "config.yaml").read_text(errors="ignore").splitlines():
            m = re.match(r"\s+(title|short_name):\s*[\"']?(.*?)[\"']?\s*(#.*)?$", line)
            if m and m.group(2):
                return m.group(2)
    except OSError:
        pass
    return project.name


def results_newer_than_spine(project):
    try:
        spine = (project / ".mstack" / "spine.md").stat().st_mtime
    except OSError:
        return False
    for pattern in RESULT_GLOBS:
        for f in glob.glob(str(project / pattern)):
            try:
                if os.stat(f).st_mtime > spine + 1:
                    return True
            except OSError:
                continue
    return False


def main():
    try:
        payload = json.load(sys.stdin)
    except (json.JSONDecodeError, ValueError, OSError):
        payload = {}
    start = payload.get("cwd") or os.environ.get("CLAUDE_PROJECT_DIR") or os.getcwd()
    project = find_project(start)
    if project is None:
        return
    name = title(project)
    fields, last = read_spine(project)
    if "Claim" not in fields:
        print(f'MStack paper "{name}": .mstack/spine.md holds no claim yet, so reviews and drafts in this '
              "folder have no stated main idea to rank against. /mstack:research-question writes the first "
              "version; /mstack:claim-sharpen develops it.")
        return
    print(f'MStack paper "{name}". Its main idea, as recorded in .mstack/spine.md:')
    print()
    for field in FIELDS:
        print(f"{field}: {fields.get(field, '(not yet written)')}")
    if last:
        print(f"Last change: {last}")
    print()
    print("In this folder, feedback, analysis, and drafting are ranked by their bearing on that claim: "
          "what would break it comes first, what would narrow it second, and points that leave it "
          "untouched are kept short or left out unless the author asks for them. The spine changes "
          "only by an edit with a dated line in its log.")
    if results_newer_than_spine(project):
        print("The results audit or robustness memo is newer than the spine, so the claim may predate "
              "what was found; /mstack:claim-sharpen restates it against the results.")


if __name__ == "__main__":
    try:
        main()
    except Exception:  # a context hook must never block a session
        pass
    sys.exit(0)
