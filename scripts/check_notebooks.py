#!/usr/bin/env python3
"""Check that notebook files are valid JSON notebooks."""

from __future__ import annotations

import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
NOTEBOOK_DIRS = (ROOT / "workshops", ROOT / "shared")


def validate_notebook(path: Path) -> str | None:
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as exc:
        return f"{path}: invalid JSON at line {exc.lineno}, column {exc.colno}"

    if not isinstance(data, dict):
        return f"{path}: notebook root must be an object"
    if not isinstance(data.get("cells"), list):
        return f"{path}: missing cells list"
    if not isinstance(data.get("metadata"), dict):
        return f"{path}: missing metadata object"
    if "nbformat" not in data or "nbformat_minor" not in data:
        return f"{path}: missing nbformat metadata"
    return None


def main() -> int:
    notebooks = sorted(path for root in NOTEBOOK_DIRS if root.exists() for path in root.rglob("*.ipynb"))
    if not notebooks:
        print("No notebooks found.", file=sys.stderr)
        return 1

    errors = [error for notebook in notebooks if (error := validate_notebook(notebook))]
    if errors:
        for error in errors:
            print(error, file=sys.stderr)
        return 1

    print(f"Validated {len(notebooks)} notebook(s).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
