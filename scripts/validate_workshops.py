#!/usr/bin/env python3
"""Validate workshop manifests and referenced files."""

from __future__ import annotations

from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
WORKSHOPS_DIR = ROOT / "workshops"
REQUIRED_FIELDS = {
    "slug",
    "title",
    "leads",
    "summary",
    "entrypoints",
    "notebooks",
    "assets",
    "python_dependencies",
    "system_dependencies",
    "smoke_commands",
}


def parse_scalar(value: str) -> str:
    value = value.strip()
    if len(value) >= 2 and value[0] == value[-1] and value[0] in {"'", '"'}:
        return value[1:-1]
    return value


def parse_manifest(path: Path) -> dict[str, object]:
    data: dict[str, object] = {}
    current_key: str | None = None
    current_item: dict[str, str] | None = None

    for line_number, raw_line in enumerate(path.read_text(encoding="utf-8").splitlines(), start=1):
        if not raw_line.strip() or raw_line.lstrip().startswith("#"):
            continue

        if not raw_line.startswith(" "):
            if ":" not in raw_line:
                raise ValueError(f"{path}:{line_number}: expected 'key: value'")
            key, value = raw_line.split(":", 1)
            key = key.strip()
            value = value.strip()
            if value:
                data[key] = parse_scalar(value)
                current_key = None
                current_item = None
            else:
                data[key] = []
                current_key = key
                current_item = None
            continue

        if current_key is None:
            raise ValueError(f"{path}:{line_number}: indented value without a parent key")

        stripped = raw_line.strip()
        target = data[current_key]
        if not isinstance(target, list):
            raise ValueError(f"{path}:{line_number}: parent key '{current_key}' is not a list")

        if stripped.startswith("- "):
            item = stripped[2:].strip()
            if ": " in item:
                item_key, item_value = item.split(":", 1)
                current_item = {item_key.strip(): parse_scalar(item_value)}
                target.append(current_item)
            else:
                current_item = None
                target.append(parse_scalar(item))
            continue

        if current_item is None or ":" not in stripped:
            raise ValueError(f"{path}:{line_number}: expected list item property")
        item_key, item_value = stripped.split(":", 1)
        current_item[item_key.strip()] = parse_scalar(item_value)

    return data


def as_list(manifest: dict[str, object], key: str) -> list[object]:
    value = manifest.get(key)
    if not isinstance(value, list):
        raise ValueError(f"'{key}' must be a list")
    return value


def path_from_entry(entry: object) -> str:
    if isinstance(entry, str):
        return entry
    if isinstance(entry, dict) and isinstance(entry.get("path"), str):
        return entry["path"]
    raise ValueError("each entrypoint must be a path string or a mapping with a path")


def validate_manifest(workshop_dir: Path) -> list[str]:
    errors: list[str] = []
    manifest_path = workshop_dir / "workshop.yaml"
    readme_path = workshop_dir / "README.md"

    if not manifest_path.exists():
        return [f"{workshop_dir}: missing workshop.yaml"]
    if not readme_path.exists():
        errors.append(f"{workshop_dir}: missing README.md")

    try:
        manifest = parse_manifest(manifest_path)
    except ValueError as exc:
        return [str(exc)]

    missing = sorted(REQUIRED_FIELDS - set(manifest))
    if missing:
        errors.append(f"{manifest_path}: missing required fields: {', '.join(missing)}")

    slug = manifest.get("slug")
    if slug != workshop_dir.name:
        errors.append(f"{manifest_path}: slug must match folder name '{workshop_dir.name}'")

    for key in ("leads", "notebooks", "assets", "python_dependencies", "system_dependencies", "smoke_commands"):
        try:
            as_list(manifest, key)
        except ValueError as exc:
            errors.append(f"{manifest_path}: {exc}")

    try:
        entrypoints = as_list(manifest, "entrypoints")
    except ValueError as exc:
        errors.append(f"{manifest_path}: {exc}")
        entrypoints = []

    for key in ("notebooks", "assets"):
        try:
            listed_paths = as_list(manifest, key)
        except ValueError:
            continue
        for item in listed_paths:
            if not isinstance(item, str):
                errors.append(f"{manifest_path}: '{key}' values must be path strings")
                continue
            target = workshop_dir / item
            if not target.exists():
                errors.append(f"{manifest_path}: missing referenced {key[:-1]} '{item}'")
            if key == "notebooks" and target.suffix != ".ipynb":
                errors.append(f"{manifest_path}: notebook path must end in .ipynb: '{item}'")

    for entry in entrypoints:
        try:
            entry_path = path_from_entry(entry)
        except ValueError as exc:
            errors.append(f"{manifest_path}: {exc}")
            continue
        if not (workshop_dir / entry_path).exists():
            errors.append(f"{manifest_path}: missing entrypoint '{entry_path}'")

    return errors


def discover_workshop_dirs() -> list[Path]:
    if not WORKSHOPS_DIR.exists():
        return []
    return sorted(path for path in WORKSHOPS_DIR.iterdir() if path.is_dir())


def main() -> int:
    workshop_dirs = discover_workshop_dirs()
    if not workshop_dirs:
        print("No workshop folders found.", file=sys.stderr)
        return 1

    errors: list[str] = []
    for workshop_dir in workshop_dirs:
        errors.extend(validate_manifest(workshop_dir))

    if errors:
        for error in errors:
            print(error, file=sys.stderr)
        return 1

    print(f"Validated {len(workshop_dirs)} workshop folder(s).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
