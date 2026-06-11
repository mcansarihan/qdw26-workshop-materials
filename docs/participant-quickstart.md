# Participant Quickstart

Welcome to the Quantum Device Workshop! This guide gets you from "I have the
launchable link" to "I'm running the tutorials and writing my own code" in a few
minutes. No local installation is required — everything runs in your cloud
workspace.

You can work however you prefer:

- **Section 1 — JupyterLab in your browser** ⭐ *recommended*: nothing to
  install — open one tab and the environment (kernel, all packages) is already
  selected for you. A full editor *and* notebook environment.
- **Section 2 — VS Code in your browser**: a real VS Code, running in your
  workspace, with the environment already selected. For people who prefer VS Code.
- **Section 3 — GUI apps in the browser** (KLayout, the Qiskit Metal GUI,
  ParaView): for the design project, when you want real desktop tools.

All three are just browser tabs — **no SSH, no local install, nothing to
configure.** They share the same files and environment; switch anytime. (Prefer
to run on your *own* machine instead? See "Run everything locally with Docker" at
the end.)

---

## Step 0 — Create your workspace

1. Open the launchable link the organizers sent you.
2. Choose the **recommended workspace size: `TBD`** *(organizers will confirm the
   exact instance before the event)*. This workshop is **CPU‑only — you do not
   need a GPU.** The simulations (Palace) run on CPU cores, so a GPU would add
   cost without making anything faster.
3. Create the workspace and wait for it to finish starting.

On the **first** start, the workspace automatically pulls the prebuilt workshop
image and launches everything (this one‑time step takes a few minutes). When
it's done, three services are already running inside your workspace:

| Service | Port | What it's for |
|---|---|---|
| JupyterLab | `8888` | Run the notebooks in your browser (Section 1) |
| VS Code (code‑server) | `8080` | A full VS Code in your browser (Section 2) |
| Web desktop (noVNC) | `6080` | Open GUI apps like KLayout (Section 3) |

You don't need to start anything by hand — all three come back automatically
every time you resume the workspace.

> **Accessing a port.** In the Brev console, open your workspace and use its
> port/URL access to reach port `8888` (Jupyter), `8080` (VS Code), or `6080`
> (desktop). If you prefer the CLI, forward a port to your laptop:
> ```bash
> brev port-forward <your-workspace-name> -p 8888:8888
> # then open http://localhost:8888   (use 8080 for VS Code, 6080 for the desktop)
> ```

---

## Section 1 — Run notebooks in your browser (JupyterLab) ⭐

The zero‑setup path — recommended for everyone, especially to start.

1. Open port **`8888`** for your workspace (see "Accessing a port" above).
2. JupyterLab opens directly — **no password, no token, no environment to pick**.
   The workshop kernel (with every package) is already the default.
3. In the file browser on the left, open:
   - `workshops/quantum-device-design/notebooks/` — start at `01_welcome.ipynb`
     and work upward (`02_…`, `03_…`, `04_…`, `05_project.ipynb`).
   - `workshops/electromagnetic-simulations/notebooks/` — `eigenmode_EPR.ipynb`
     and `electrostatic_LOM.ipynb`.
4. Run cells with **Shift+Enter**. Layout previews and plots render inline.

That's it — you're ready for the whole workshop from here.

---

## Section 2 — VS Code in your browser (code‑server)

If you prefer VS Code, your workspace runs a full **VS Code in the browser** with
the workshop environment already wired up — **no SSH, no "attach to container",
nothing to install.**

1. Open port **`8080`** for your workspace (see "Accessing a port" above) — e.g.
   `http://localhost:8080` if you port‑forwarded. VS Code loads right away.
2. The folder `/home/ubuntu/qdw-workshop-materials` is already open, the **Python
   and Jupyter extensions are pre‑installed**, and the interpreter/kernel is
   already set to the workshop venv (`…/.venv/bin/python`).
3. Open any notebook under `workshops/…/notebooks/` and run cells, or open a
   `.py` file and use the integrated terminal + debugger. Breakpoints work.

> This is the recommended way to use VS Code here.

### Power-user: your *local* VS Code / Cursor (attach to the container)

You can also drive the workspace from your **local** VS Code or Cursor, but it
takes a couple of steps and one required setting. The in-browser VS Code above is
simpler — use this only if you specifically want your local editor.

1. From your **laptop terminal**, let Brev wire up SSH and open your editor (do
   **not** type the instance name into "Connect to Host" manually — that fails to
   resolve):
   ```bash
   brev open <your-workspace-name> cursor    # or: ... code
   ```
2. **Cursor only — one required setting.** Cursor's container-attach crashes
   while copying your git config (`Failed to read .gitconfig … path … undefined`).
   In Cursor → **Settings (JSON)**, add:
   ```json
   "dev.containers.copyGitConfig": false
   ```
3. Command Palette → **"Dev Containers: Attach to Running Container"** → pick the
   container ending in **`-dev-1`** (e.g. `workspace-dev-1`) → open
   `/home/ubuntu/qdw-workshop-materials` and select the `.venv` interpreter.

If any of this misbehaves, fall back to the in-browser VS Code (port 8080) — it
gives the same experience with none of the SSH/attach setup.

---

## Section 3 — Open GUI apps (KLayout, Qiskit Metal GUI) in your browser

For the design project you may want real desktop tools — **KLayout** to inspect
a GDS layout, the **Qiskit Metal GUI**, or **ParaView** for field plots. They run
on a lightweight Linux desktop inside your workspace that you reach from a
**browser tab** — no XQuartz / VcXsrv / X‑server, nothing to install.

1. Open port **`6080`** for your workspace and go to **`/vnc.html`** (e.g.
   `http://localhost:6080/vnc.html` if you port‑forwarded), then click
   **Connect**. A desktop appears, with a terminal already open.
2. **To open KLayout**, do either:
   - **Right‑click the desktop background → KLayout**, or
   - type **`klayout`** in the desktop terminal.

   Then in KLayout use *File → Open* to load a `.gds` file. To create one, export
   it from a notebook first — e.g. `design.export_to_gds("my_chip.gds")` — and it
   lands in your materials directory.
3. **To open the Qiskit Metal Qt GUI**, type this in the desktop terminal:
   ```python
   python
   >>> from qiskit_metal import designs, MetalGUI
   >>> design = designs.DesignPlanar()
   >>> gui = MetalGUI(design)
   ```
   The window appears on the web desktop.

> Notebooks themselves always render **inline** (the kernel is intentionally
> headless), so the GUI desktop is only needed when you explicitly want a
> separate application window.

### Power‑user alternative: X11 over SSH

If you'd rather have native windows on your own machine, you can forward X11
over SSH instead of using the web desktop. This requires a local X server
(XQuartz on macOS, VcXsrv on Windows; Linux works out of the box). See
[gui-forwarding.md](gui-forwarding.md).

---

## Tuning Palace CPU usage (optional)

The simulations use as many CPU cores as your instance physically has, chosen
automatically so Palace never fails with *"not enough slots available"*. To use
**fewer** cores (e.g. to leave headroom), set the **`QDW_PALACE_CPUS`**
environment variable to a number **≤ your instance's physical cores** before
starting the services — for example `QDW_PALACE_CPUS=4`. You normally don't need
to touch this.

---

## Pause between sessions, resume in seconds

To preserve your allotted compute, **pause (stop) your workspace whenever you're
not actively using it** — during lectures, breaks, and overnight.

- **Pause:** stop the workspace from the Brev console (or `brev stop <name>`).
- **Resume:** start it again (or `brev start <name>`). JupyterLab, VS Code, and
  the desktop **restart automatically** — just reopen the port `8888` / `8080` /
  `6080` URLs. Resume is fast because the image is already cached on your
  workspace disk; nothing is rebuilt or re‑downloaded.

You do **not** need to re‑run any setup commands on resume.

---

## Run everything locally with Docker (advanced, optional)

<details>
<summary>Prefer to run on your own machine instead of the cloud workspace? Click to expand.</summary>

Everything here is just a public repo + a prebuilt Docker image, so you can run
the whole stack locally with Docker Desktop (macOS/Windows/Linux). You get the
same JupyterLab, VS Code, and desktop on `localhost`.

```bash
# 1. Clone the repo
git clone https://github.com/quantum-device-consortium/qdw26-workshop-materials.git
cd qdw26-workshop-materials

# 2. Pull the prebuilt image and start the services
docker compose -f compose.deploy.yaml pull
docker compose -f compose.deploy.yaml up -d
```

Then open in your browser:

- **JupyterLab** → <http://localhost:8888>
- **VS Code** → <http://localhost:8080>
- **Web desktop (KLayout / GUIs)** → <http://localhost:6080/vnc.html>

Notes:

- The image is `linux/amd64`. On Apple Silicon it runs under emulation
  (slower) — fine for layout/analysis. See the Apple Silicon note below for the
  Palace simulations.
- Stop everything with `docker compose -f compose.deploy.yaml down`.
- To rebuild from source instead of pulling, use `docker compose up --build`
  (the dev `compose.yaml`), which also bind‑mounts your local checkout.

#### ⚠️ Apple Silicon (M1/M2/M3/M4): "Illegal instruction" during a Palace simulation

If a **simulation** cell crashes with **`Illegal instruction`** (exit code
`132`, `-4`, or `139`) — e.g.:

```
RuntimeError: Palace exited with status 132 ...
palace: line 179: ... Illegal instruction   $MPIRUN $PALACE $CONFIG
```

…the cause is **how Docker emulates x86 on your Mac**, not a bug in the
notebook. Palace is a precompiled x86 binary that uses AVX vector instructions,
and Docker Desktop's **Rosetta** emulation does **not** support them (it traps
them as illegal). The **QEMU** emulator does — Palace runs fine under QEMU
(just slower), which we've verified on Apple Silicon.

**Fix:** switch Docker Desktop to QEMU emulation:

1. Docker Desktop → **Settings → General**.
2. **Uncheck** "Use Rosetta for x86_64/amd64 emulation on Apple Silicon".
3. **Apply & Restart**, then re-run the notebook.

Layout/analysis cells work either way; this only affects the FEM **simulation**
cells. If you'd rather not wait on emulation at all, run the simulation
notebooks on the **Brev cloud workspace** (native x86) or any Intel/AMD Linux
machine — they're dramatically faster there.

</details>

---

## Saving your work

- Files you edit inside the materials directory **persist across pause/resume**.
- Don't rely on the workspace as long‑term storage — **download** anything
  important (see below) or push it to your **own** git repo before the workshop
  ends.

### Download files from your workspace to your computer

**From the browser (easiest, per file):**

- In **JupyterLab** (8888) or **VS Code** (8080): right‑click a file in the file
  browser → **Download**. Works for notebooks, GDS files, plots, logs, etc.
- To grab **many files at once**, open a terminal (in Jupyter, VS Code, or the
  desktop) and zip them first, then download the single zip:
  ```bash
  cd /home/ubuntu/qdw-workshop-materials
  zip -r my_work.zip workshops/quantum-device-design/notebooks/sims my_chip.gds
  ```
  then right‑click `my_work.zip` → **Download**.

**From your laptop's terminal (whole folders), using the Brev CLI:**

```bash
# one file
brev copy <your-workspace-name>:/home/ubuntu/qdw-workshop-materials/my_chip.gds ./

# a whole folder (note the trailing slashes)
brev copy <your-workspace-name>:/home/ubuntu/qdw-workshop-materials/workshops/ ./qdw-download/
```

`brev copy` reads from **inside the container by default** — i.e. exactly where
your notebook work lives — so you don't need to worry about host-vs-container
paths. (Reverse the arguments to upload files *to* your workspace.)

---

## Quick troubleshooting

| Symptom | Fix |
|---|---|
| Jupyter / desktop tab won't load right after resume | Give it ~15–30s to restart, then refresh. |
| A simulation is slow | Expected — Palace is CPU/MPI. Don't add a GPU; it isn't used. |
| Web desktop is black / empty | Right‑click the background for the app menu. If the bottom bar shows a workspace other than "Workshop", click the ◄ arrow to get back to it. Then refresh `/vnc.html` → **Connect**. |
| KLayout / a GUI app won't open | Open it from the desktop terminal (`klayout`) and read any error there; make sure you're using the **6080** desktop, not a notebook. |
| Palace: "not enough slots available" | Already handled (cores are auto-detected). If you raised `QDW_PALACE_CPUS`, lower it to ≤ your instance's physical cores. |
| Palace: "Illegal instruction" (exit 132 / -4 / 139) — **local Docker on Apple Silicon only** | Docker's Rosetta emulation can't run Palace's AVX instructions. Switch Docker Desktop to QEMU (Settings → General → uncheck "Use Rosetta…"), or run sims on the Brev workspace. See the Apple Silicon note in "Run everything locally with Docker". |
| Want VS Code but local Cursor/SSH is acting up | Use the in-browser VS Code on port **8080** (Section 2) — it avoids all SSH/attach issues. |
| Cursor attach: "Could not resolve hostname …" | Don't type the instance name into "Connect to Host". Open it via `brev open <name> cursor` from your terminal so Brev sets up SSH. |
| Cursor attach: "Failed to read .gitconfig … path … undefined" | In Cursor → Settings (JSON) add `"dev.containers.copyGitConfig": false`, then retry "Attach to Running Container". |
| Lost the port URL | Reopen it from the Brev console, or re‑run `brev port-forward`. |

Stuck? Reach the organizers at **quantum.ucla@gmail.com**.
