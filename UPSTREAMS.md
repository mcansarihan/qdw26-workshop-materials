# Upstreams

Imported on 2026-05-15.

| Material | Source | Imported commit |
| --- | --- | --- |
| QDW playground Docker environment | https://github.com/abhishekchak52/qdw26-playground | `3fa8d7375eb09dca2bb65719d7fd5c1293b0b6a0` |
| Quantum device design tutorials | https://github.com/zlatko-minev/tutorials_quantum_device_design | `7249a95cd90c40837a1f5fc766728478f7ad191f` |

## Import Layout

- QDW playground files are kept at the repository root so `docker compose up --build` mounts the full joint repo into the development container.
- Quantum device design tutorial files are kept under `workshops/quantum-device-design/`.
- Shared Palace examples are kept under `shared/palace_examples/`.
