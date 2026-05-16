# Shared Environment

The repository root defines the environment used by all workshops.

## Files

- `Dockerfile`: system packages, Palace base image, Python runtime, and `uv`.
- `pyproject.toml`: Python dependency requests that are installed into the shared environment.
- `uv.lock`: locked Python resolution.
- `compose.yaml`: local and Brev runtime entrypoint.

## Dependency Policy

Workshop leads declare requested dependencies in their `workshop.yaml`. Maintainers update the shared root environment so attendees use one consistent setup.

## Image

The canonical image target is:

```text
ghcr.io/quantum-device-consortium/qdw-workshop-materials
```

CI publishes `main` and `sha-<shortsha>` tags after successful builds on `main`.
The image contains the shared environment and the repository materials at `/home/ubuntu/qdw-workshop-materials`.

## Smoke Checks

Smoke checks should confirm the environment can start and workshops can be opened. They should not run long simulations in pull requests.
