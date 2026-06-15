# Circuit Analysis & Simulation

**Workshop lead:** Professor Jens Koch · **When:** Day 2 (June 16), 11:15 AM – 12:00 PM

Circuit-Hamiltonian analysis and simulation of superconducting qubits with
[**scqubits**](https://scqubits.readthedocs.io/) — build qubit/resonator models,
compute spectra and matrix elements, and explore parameter sweeps interactively.

## Get this notebook onto your workspace

Your workspace's pre-loaded copy is a snapshot, so it may not include this
notebook yet. **Paste this into any terminal** (JupyterLab / VS Code / desktop) -
it drops the latest notebook straight into the right place in your materials, no
matter what folder you're in:

```bash
mkdir -p ~/qdw-workshop-materials/workshops/circuit-analysis/notebooks && \
  curl -fsSL https://raw.githubusercontent.com/quantum-device-consortium/qdw26-workshop-materials/main/workshops/circuit-analysis/notebooks/circuit_analysis.ipynb \
  -o ~/qdw-workshop-materials/workshops/circuit-analysis/notebooks/circuit_analysis.ipynb && \
  echo "Done - open  workshops/circuit-analysis/notebooks/circuit_analysis.ipynb"
```

Then open **`workshops/circuit-analysis/notebooks/circuit_analysis.ipynb`** from
the file browser and run it top to bottom.

> 🛑 Re-running this **overwrites that one notebook** with the latest version, so
> if you've already edited it and want to keep your changes, **save a copy first**
> (e.g. rename it, or download it).

## Materials

The workshop notebooks live in [`notebooks/`](notebooks/). Open them in
JupyterLab or VS Code and run top to bottom.

> [!NOTE]
> `scqubits` ships an interactive GUI that runs **inline** in a notebook —
> `import scqubits; scqubits.GUI()` (use `%matplotlib widget` for live plots).

## Environment

Everything you need is already installed in the workspace (`scqubits`,
`ipywidgets`, `ipympl`, JupyterLab). Nothing to set up.
