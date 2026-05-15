# Workshops

Workshop materials live in separate subdirectories so each workshop can evolve independently while sharing the same root Docker environment.

## Current Materials

- `tutorials_quantum_device_design/`: Qiskit Metal, Palace, and SQDMetal tutorial materials.

## Adding Another Workshop

Add new materials under a descriptive subdirectory:

```bash
mkdir -p workshops/<workshop-name>
```

If the workshop needs additional Python or system dependencies, update the root `pyproject.toml`, `uv.lock`, or `Dockerfile` so the shared environment remains reproducible.
