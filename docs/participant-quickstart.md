# Participant Quickstart

Welcome to the Quantum Device Workshop! This guide gets you from "I have the
launchable link" to "I'm running the tutorials and writing my own code" in a few
minutes. No local installation is required — everything runs in your cloud
workspace.

You can work however you prefer:

- **Section 1 — Browser (JupyterLab)** ⭐ *recommended*: nothing to install, no
  setup — open one tab and the environment (kernel, all packages) is already
  selected for you.
- **Section 2 — Your own IDE** (VS Code / Cursor): edit and run notebooks with
  your familiar editor, autocomplete, and debugger.
- **Section 3 — GUI apps in the browser** (KLayout, the Qiskit Metal GUI): for
  the design project, when you want to open real desktop tools.

**If you just want to start fast, use Section 1.** All three share the same files
and environment, and you can switch anytime.

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
it's done, two services are already running inside your workspace:

| Service | Port | What it's for |
|---|---|---|
| JupyterLab | `8888` | Run the notebooks in your browser (Section 2) |
| Web desktop (noVNC) | `6080` | Open GUI apps like KLayout (Section 3) |

You don't need to start anything by hand — both come back automatically every
time you resume the workspace.

> **Accessing a port.** In the Brev console, open your workspace and use its
> port/URL access to reach port `8888` (Jupyter) or `6080` (desktop). If you
> prefer the CLI, forward a port to your laptop:
> ```bash
> brev port-forward <your-workspace-name> -p 8888:8888
> # then open http://localhost:8888
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

## Section 2 — Use your own IDE (VS Code or Cursor)

Optional — for autocomplete, an integrated terminal, and a debugger. The
workshop environment lives **inside a Docker container** on your workspace, so
your editor needs to *attach to that container* (not just open the host). It's
two clicks and the environment is then pre‑configured for you.

1. **Open the workspace.** From the Brev console choose **Open in VS Code / Cursor**,
   or from the CLI:
   ```bash
   brev open <your-workspace-name> cursor    # or: ... code
   ```
   This connects your editor to the workspace **host**. (The first time, if it
   ever says it can't reach Docker, just reconnect once — *Command Palette →
   "Remote‑SSH: Kill VS Code Server on Host" → reopen* — and continue.)
2. **Attach to the container.** Install the **Dev Containers** extension if
   prompted, then *Command Palette → "Dev Containers: Attach to Running
   Container…"* and pick the container whose name ends in **`-dev-1`** (e.g.
   `workspace-dev-1`).
3. A new window opens **inside** the container. Open the folder
   `/home/ubuntu/qdw-workshop-materials`.
4. Open any notebook under `workshops/…/notebooks/` and run it. The Python /
   Jupyter extensions and the correct kernel
   (`…/.venv/bin/python`) are **already selected** — nothing to choose.
   Breakpoints and the debugger work out of the box.

> If you ever see only host interpreters like `/usr/bin/python3` and an
> "ipykernel is missing" message, it means your editor is on the **host**, not
> attached to the container — redo step 2.

---

## Section 3 — Open GUI apps in your browser (design project)

For the open‑ended design project you may want real desktop tools — **KLayout**
to inspect a GDS layout, or the **Qiskit Metal GUI**. These run on a lightweight
Linux desktop inside your workspace that you reach from a browser tab. No
XQuartz / VcXsrv / X‑server setup needed.

1. Open port **`6080`** for your workspace and go to `/vnc.html` (e.g.
   `http://localhost:6080/vnc.html` if you port‑forwarded), then click
   **Connect**.
2. You'll see a desktop. **Right‑click the desktop background** to open the
   menu:
   - **Terminal** — a shell already in the materials directory.
   - **KLayout** — open a `.gds` file via *File → Open* (export one from a
     notebook first, e.g. with `design.export_to_gds(...)`).
   - **ParaView** — inspect Palace field results.
3. To open the **Qiskit Metal Qt GUI**, use a desktop **Terminal** and run:
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

## Pause between sessions, resume in seconds

To preserve your allotted compute, **pause (stop) your workspace whenever you're
not actively using it** — during lectures, breaks, and overnight.

- **Pause:** stop the workspace from the Brev console (or `brev stop <name>`).
- **Resume:** start it again (or `brev start <name>`). JupyterLab and the desktop
  **restart automatically** — just reopen the port `8888` / `6080` URLs. Resume
  is fast because the image is already cached on your workspace disk; nothing is
  rebuilt or re‑downloaded.

You do **not** need to re‑run any setup commands on resume.

---

## Saving your work

- Files you edit inside the materials directory **persist across pause/resume**.
- For a permanent copy you keep after the workshop, either **download** notebooks
  from JupyterLab (right‑click → Download) or push to your **own** git repo.
- Don't rely on the workspace as long‑term storage — back up anything important
  before the workshop ends.

---

## Quick troubleshooting

| Symptom | Fix |
|---|---|
| Jupyter / desktop tab won't load right after resume | Give it ~15–30s to restart, then refresh. |
| IDE shows only `/usr/bin/python3` / "ipykernel missing" | Your editor is on the host, not the container — do Section 2 step 2 ("Attach to Running Container"). |
| A simulation is slow | Expected — Palace is CPU/MPI. Don't add a GPU; it isn't used. |
| Web desktop is black | Click into it once; if still black, refresh `/vnc.html` and **Connect** again. |
| Lost the port URL | Reopen it from the Brev console, or re‑run `brev port-forward`. |

Stuck? Reach the organizers at **quantum.ucla@gmail.com**.
