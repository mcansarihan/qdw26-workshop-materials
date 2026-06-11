# Participant Quickstart

Welcome to the Quantum Device Workshop! This guide gets you from "I have the
launchable link" to "I'm running the tutorials and writing my own code" in a few
minutes. No local installation is required — everything runs in your cloud
workspace.

You can work however you prefer:

- **Section 1 — Browser (JupyterLab)** ⭐ *recommended*: nothing to install, no
  setup — open one tab and the environment (kernel, all packages) is already
  selected for you. This is a full editor *and* notebook environment.
- **Section 2 — GUI apps in the browser** (KLayout, the Qiskit Metal GUI,
  ParaView): for the design project, when you want real desktop tools.
- **(Advanced) VS Code / Cursor**: supported but fiddlier on Brev — see the note
  near the end. Most people should just use JupyterLab.

**If you just want to start fast, use Section 1.** Everything shares the same
files and environment, and you can switch anytime.

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
| JupyterLab | `8888` | Run the notebooks in your browser (Section 1) |
| Web desktop (noVNC) | `6080` | Open GUI apps like KLayout (Section 2) |

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

## Section 2 — Open GUI apps (KLayout, Qiskit Metal GUI) in your browser

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

## (Advanced) Using VS Code or Cursor

**We recommend JupyterLab (Section 1) for the workshop** — it's a full editor
*and* notebook environment (file browser, code editor, integrated terminal, and
a visual debugger), with zero setup.

If you specifically want VS Code / Cursor, note that the workshop environment
lives **inside a container**, so your editor has to *attach to that container* —
not just open the workspace host (where there is no environment). `brev open`
connects you to the **host**, then you must run *"Attach to Running Container"*
and pick the container ending in **`-dev-1`**. This works but is fiddly on some
setups (Cursor needs its own container extension; you may need one clean
reconnect for Docker access). If you hit friction, just use JupyterLab — you lose
nothing.

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
| A simulation is slow | Expected — Palace is CPU/MPI. Don't add a GPU; it isn't used. |
| Web desktop is black / empty | Right‑click the background for the app menu. If the bottom bar shows a workspace other than "Workshop", click the ◄ arrow to get back to it. Then refresh `/vnc.html` → **Connect**. |
| KLayout / a GUI app won't open | Open it from the desktop terminal (`klayout`) and read any error there; make sure you're using the **6080** desktop, not a notebook. |
| VS Code/Cursor shows only `/usr/bin/python3` | Your editor is on the host, not the container — see the "Advanced: VS Code/Cursor" note, or just use JupyterLab. |
| Lost the port URL | Reopen it from the Brev console, or re‑run `brev port-forward`. |

Stuck? Reach the organizers at **quantum.ucla@gmail.com**.
