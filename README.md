# QDW Workshop Materials

Joint workspace for Quantum Device Workshop materials, with the QDW playground Docker environment at the repository root so the same server/container can run all workshops.

## Repository Layout

- `Dockerfile`, `compose.yaml`, `pyproject.toml`, `uv.lock`: shared QDW playground environment imported from `abhishekchak52/qdw26-playground`.
- `workshops/tutorials_quantum_device_design/`: Zlatko Minev's workshop materials imported from `zlatko-minev/tutorials_quantum_device_design`.
- `docs/upstream-qdw26-playground-README.md`: original playground README preserved for reference.
- `UPSTREAMS.md`: source repositories and imported commit SHAs.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) with the Compose plugin.
- Optional: [NVIDIA Brev](https://docs.nvidia.com/brev/) for a cloud-hosted workshop server.

## Local Docker

The image installs `uv`, a managed Python, Palace via the QDW playground base image, and locked Python dependencies from `pyproject.toml` / `uv.lock`. Compose bind-mounts this whole repository into `/home/ubuntu/qdw26-playground`, so all workshop folders are visible inside the same container.

```bash
docker compose up --build
```

With the stack running, basic checks are:

```bash
docker compose exec dev uv run python main.py
docker compose exec dev palace --version
docker compose exec dev bash
```

To work on the imported tutorials inside the container:

```bash
docker compose exec dev bash
cd workshops/tutorials_quantum_device_design
```

To start JupyterLab from the container:

```bash
docker compose exec dev uv run jupyter lab --ip 0.0.0.0 --port 8888 --no-browser
```

Then open the printed Jupyter URL on your machine. Compose exposes port `8888` by default.

## NVIDIA Brev

Brev can run this repository on a cloud instance using the same Docker setup:

```bash
brev start https://github.com/<org-or-user>/<joint-repo>.git
brev open <instance-name> cursor
```

From the Brev instance:

```bash
cd <joint-repo>
docker compose up -d
docker compose exec dev bash
```

If the instance was created in the Brev web console, run `brev refresh` locally so the CLI can find it.

## Current Workshop Materials

- Quantum device design tutorials: `workshops/tutorials_quantum_device_design/`

## Notes

- This repo is initialized locally, but no GitHub remote is configured yet.
- Dependency reconciliation for each workshop should happen here so future workshops share one known-good environment.
