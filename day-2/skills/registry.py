"""Tiny skills registry: index.json (name, version, owner, approved, sha256) + loader.

The sha256 covers every file in the skill folder (CRLF normalised), so a
compliance-approved version cannot silently change.
"""
from __future__ import annotations
import hashlib, json
from pathlib import Path

ROOT = Path(__file__).parent
INDEX = ROOT / "index.json"


def folder_hash(folder: Path) -> str:
    h = hashlib.sha256()
    for f in sorted(p for p in folder.rglob("*") if p.is_file() and "__pycache__" not in p.parts):
        h.update(f.relative_to(folder).as_posix().encode())
        h.update(f.read_bytes().replace(b"\r\n", b"\n"))
    return h.hexdigest()


def build_index(approved: dict[str, str] | None = None, version: str = "1.0.0") -> dict:
    """(Re)generate entries. `approved` maps skill name -> approver; others stay unapproved."""
    approved = approved or {}
    old = {e["name"]: e for e in json.loads(INDEX.read_text())["skills"]} if INDEX.exists() else {}
    entries = []
    for d in sorted(p for p in ROOT.iterdir() if (p / "SKILL.md").exists()):
        meta = old.get(d.name, {})
        entries.append({
            "name": d.name, "version": meta.get("version", version),
            "owner": _owner(d), "approved": d.name in approved or meta.get("approved", False),
            "approved_by": approved.get(d.name, meta.get("approved_by")),
            "sha256": folder_hash(d),
        })
    return {"schema": 1, "skills": entries}


def _owner(d: Path) -> str:
    for line in (d / "SKILL.md").read_text(encoding="utf-8").splitlines():
        if line.strip().startswith("owner:"):
            return line.split(":", 1)[1].strip()
    return "unknown"


def load_index() -> dict:
    return json.loads(INDEX.read_text())


def verified_names() -> tuple[set[str], list[str]]:
    """Names that are approved AND whose folder hash matches. Returns (ok, problems)."""
    ok, problems = set(), []
    for e in load_index()["skills"]:
        d = ROOT / e["name"]
        if not e["approved"]:
            problems.append(f"{e['name']}: not approved"); continue
        if folder_hash(d) != e["sha256"]:
            problems.append(f"{e['name']}: hash mismatch (modified after approval)"); continue
        ok.add(e["name"])
    return ok, problems


if __name__ == "__main__":
    appr = {"mortgage-prequal": "j.chen", "kyc-checklist": "j.chen", "rate-disclosure": "j.chen"}
    INDEX.write_text(json.dumps(build_index(appr), indent=2) + "\n")
    print(INDEX.read_text())
