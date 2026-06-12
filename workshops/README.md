# Workshops

Each workshop lives in its own folder and declares its entrypoints,
dependencies, and smoke checks in `workshop.yaml`.

## Current Materials

- `quantum-device-design/`: **Design & Layout** (Day 1) — Quantum Metal, SQDMetal, Palace.
- `circuit-analysis/`: **Circuit Analysis & Simulation** (Day 2) — scqubits.
- `electromagnetic-simulations/`: **EM Simulations** (Day 2) — Quantum Metal, pyPalace, Palace.
- `design-project/`: **Design Project** (Day 4) — open-ended capstone.

See the top-level [`README.md`](../README.md) for the full schedule (including the
two workshops that run on locally-installed tools).

## Required Layout

```text
workshops/<slug>/
  README.md
  workshop.yaml
  notebooks/
  assets/
  references/
```

Optional files such as Binder notes, datasets, or helper scripts should stay inside the workshop folder unless they are useful across multiple workshops.
