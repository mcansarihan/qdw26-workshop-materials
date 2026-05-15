#!/usr/bin/env bash
set -euo pipefail

repo_dir=""
for candidate in \
  "$HOME/qdw-workshop-materials" \
  "$HOME/workspace/qdw-workshop-materials" \
  "/home/ubuntu/qdw-workshop-materials" \
  "/home/ubuntu/workspace/qdw-workshop-materials"; do
  if [[ -d "$candidate" ]]; then
    repo_dir="$candidate"
    break
  fi
done

if [[ -z "$repo_dir" ]]; then
  repo_dir="$(find /home/ubuntu -maxdepth 3 -type d -name qdw-workshop-materials -print -quit 2>/dev/null || true)"
fi

if [[ -z "$repo_dir" ]]; then
  echo "Could not find qdw-workshop-materials checkout on this Brev instance." >&2
  exit 1
fi

cd "$repo_dir"

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker is required for the shared workshop environment but was not found." >&2
  exit 1
fi

docker compose pull || true
docker compose up -d --build
docker compose ps
