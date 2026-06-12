# Quantum Device Design Workshop 2026

This repository contains all the workshop materials for QDW 2026.

**You don't need to install anything.** Everything runs in a cloud workspace that already has all the tools pre-built - you just connect a browser tab (or your own editor) and start working :)

> **In a hurry?** Read **[1 - Get your workspace](#1---get-your-workspace)**,
> then **[4 - Connect](#4---connect-three-ways)**, and use the
> **VS Code in the browser** link. That's enough to follow along with every
> workshop.

---

## Contents

- [1 - Get your workspace (Brev + NVIDIA credits)](#1---get-your-workspace)
- [2 - What's in this repo & the workshop schedule](#2---whats-in-this-repo--the-schedule)
- [3 - Your workspace, start to finish](#3---your-workspace-start-to-finish)
- [4 - Connect (three ways)](#4---connect-three-ways)
- [5 - GUI apps (KLayout, ParaView)](#5---gui-apps-klayout-paraview)
- [6 - Run everything locally with Docker (advanced)](#6---run-everything-locally-with-docker-advanced)
- [7 - Good to know](#7---good-to-know)
- [8 - Troubleshooting](#8---troubleshooting)
- [For maintainers & contributors](#for-maintainers--contributors)

---

## 1 - Get your workspace

Your workspace runs on **[NVIDIA Brev](https://brev.nvidia.com/)** - a service
that turns a one-click "launchable" into a ready-to-go cloud computer with our
exact pre-built environment.

> **NVIDIA is generously sponsoring QDW 2026** by providing the cloud compute
> for every participant. If you registered, you should have received **credits by
> email** - you'll apply those to your Brev account below.

**Set it up once (≈ 2 minutes):**

1. **Create / log into a Brev account** at **<https://brev.nvidia.com/>**.
2. **Apply your workshop credits** from the email NVIDIA sent you (Account →
   Billing / Credits).
3. **Open the workshop launchable:**
   👉 **<https://brev.nvidia.com/launchable/deploy/now?launchableID=env-3ENRhS8A7LpqxiH4lxUdrIKtHEQ>**
4. **Keep the recommended configuration** (it's already filled in for you - a
   **CPU** instance, **16 CPUs / 16 GiB RAM**, **GCP**, **64 GiB** storage) and
   click **Deploy Launchable**.

<img src="https://raw.githubusercontent.com/quantum-device-consortium/qdw26-workshop-materials/main/docs/images/brev-recommended-config.png" alt="Recommended Brev config: CPU, 16 CPUs, 16 GiB RAM, GCP, 64 GiB storage" width="420" />

> **Why CPU and not GPU?** We are presently in the works of making all our tools GPU native
> in the meantime we encourage the use of CPUs for this workshop given these changes have not
> been released yet.

> ⚠️ **PAUSE your workspace between sessions - VERY IMPORTANT!**
> Your credits are spent while the workspace is **running**, even if you're in a
> lecture and not using it. **Stop it** whenever you step away (during lectures,
> breaks, lunch, and overnight) and **start it** again when your next hands-on
> session begins. Your files are preserved, and resuming takes seconds.
> _(Stop/Start live in the Brev console in the browser, or via your terminal `brev stop <name>` / `brev start <name>`.)_

---

## 2 - What's in this repo & the schedule

When your workspace starts, it automatically clones this repository. There
are a number of folders for the environment and tooling, but as a participant
the only one you care about is **[`workshops/`](https://github.com/quantum-device-consortium/qdw26-workshop-materials/tree/main/workshops)** - each
hands-on workshop has its own folder in there with notebooks and a short README.

```text
qdw26-workshop-materials/
├─ workshops/                  ← 👈 YOU ARE HERE - all hands-on materials
│  ├─ quantum-device-design/      Design & Layout      (Day 1)
│  ├─ circuit-analysis/           Circuit Analysis      (Day 2)
│  ├─ electromagnetic-simulations/ EM Simulations       (Day 2)
│  └─ design-project/             Design Project        (Day 4)
├─ docs/                       Extra guides (you rarely need these)
├─ shared/                     Example data shared across workshops
└─ … environment files (Dockerfile, compose, scripts) - ignore these
```

> Every workshop folder has its **own `README.md`** - open it first; it tells
> you which notebook to start with and in what order.

### The schedule - and where each workshop's materials live

Not every workshop has code _in this repo_ - a couple run on tools you'll connect
to locally on the day. Here's the full map:

| Workshop (hands-on)               | When                                   | Lead(s)                          | Where the materials are                                                                                                                                           |
| --------------------------------- | -------------------------------------- | -------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Design & Layout**               | Day 1 · Mon Jun 15 · 4:15–5:00 PM      | Murat Can Sarihan                | [`workshops/quantum-device-design/`](https://github.com/quantum-device-consortium/qdw26-workshop-materials/tree/main/workshops/quantum-device-design)             |
| **Circuit Analysis & Simulation** | Day 2 · Tue Jun 16 · 11:15 AM–12:00 PM | Jens Koch                        | [`workshops/circuit-analysis/`](https://github.com/quantum-device-consortium/qdw26-workshop-materials/tree/main/workshops/circuit-analysis)                       |
| **EM Simulations**                | Day 2 · Tue Jun 16 · 2:15–3:00 PM      | Firas Abouzahr · Sara Sussman    | [`workshops/electromagnetic-simulations/`](https://github.com/quantum-device-consortium/qdw26-workshop-materials/tree/main/workshops/electromagnetic-simulations) |
| **Full Device Simulation**        | Day 2 · Tue Jun 16 · 4:15–5:00 PM      | Dane Thompson (Synopsys / Qolab) | 🖥️ **Runs locally** - Ansys licenses + files are handed out on **Day 1**. Not in this repo.                                                                       |
| **EM & Circuit Analysis**         | Day 3 · Wed Jun 17 · 1:30–2:15 PM      | David Pahl & Lucas Pahl (MIT)    | 🌐 **Runs locally** - a browser-based tool you'll connect to. Not in this repo.                                                                                   |
| **Design Project**                | Day 4 · Thu Jun 18 (all day)           | Murat Can Sarihan                | [`workshops/design-project/`](https://github.com/quantum-device-consortium/qdw26-workshop-materials/tree/main/workshops/design-project)                           |

> **Heads-up on the two "runs locally" workshops:**
>
> - **Full Device Simulation** uses **Ansys** - you'll get a license + the files
>   to run it on your own laptop, distributed on Day 1.
> - **EM & Circuit Analysis** uses a **browser-based tool** from the MIT team -
>   you'll connect to it on the day; nothing to install ahead of time.

---

## 3 - Your workspace, start to finish

After you click **Deploy Launchable**, Brev provisions your workspace. This takes
**a few minutes** the first time (it pulls the pre-built image). You'll find your
workspace anytime in the Brev console under **Environments** (look under the
**GPU** / Environments area).

**While it's building** you'll see _Compute: Deploying_ and _Container: Waiting_:

<img src="https://raw.githubusercontent.com/quantum-device-consortium/qdw26-workshop-materials/main/docs/images/workspace-building.png" alt="Workspace building - Deploying / Waiting" width="800" />

**When it's ready** it flips to _Compute: Running_ and _Container: Built_:

<img src="https://raw.githubusercontent.com/quantum-device-consortium/qdw26-workshop-materials/main/docs/images/workspace-ready.png" alt="Workspace ready - Running / Built" width="800" />

**Click your workspace** to open its page. The **Access** tab is where
everything you need lives - it lists all the ways to connect (next section):

<img src="https://raw.githubusercontent.com/quantum-device-consortium/qdw26-workshop-materials/main/docs/images/workspace-access-page.png" alt="Workspace access page" width="360" />

---

## 4 - Connect (three ways)

Your workspace runs three things you can open, each on its own link. On your
workspace's **Access** page, scroll to **"Using Secure Links"** - you'll see a
table of ready-to-click URLs:

<img src="https://raw.githubusercontent.com/quantum-device-consortium/qdw26-workshop-materials/main/docs/images/secure-links.png" alt="Using Secure Links - ports 8888, 8080, 6080" width="800" />

| Port   | Secure Link        | What it is                                                                               |
| ------ | ------------------ | ---------------------------------------------------------------------------------------- |
| `8080` | `vs-code-web-…`    | **VS Code in the browser** ⭐ recommended                                                |
| `8888` | `jupyter-lab-…`    | **JupyterLab** in the browser                                                            |
| `6080` | `no-vnc-desktop-…` | **Desktop** for GUI apps (KLayout etc.) - see [section 5](#5---gui-apps-klayout-paraview) |

> **We recommend the `vs-code-web` route**

### a) VS Code in the browser (_recommended_)

Click the **`vs-code-web-…`** link in the **Using Secure Links** table. A full
VS Code opens in your browser, already pointing at the workshop materials, with
Python + Jupyter extensions installed and the right kernel selected. Open any
notebook under `workshops/…` and run it.

<details>
<summary>Prefer the command line? (Brev CLI)</summary>

```bash
# one-time: install + log in
brew install brevdev/homebrew-brev/brev   # macOS (see the Access page for other OSes)
brev login

# forward the VS Code port to your laptop, then open the URL it prints
brev port-forward <your-workspace-name> -p 8080:8080 # `brev ls` can give your workspace name info
# → open http://localhost:8080
```

</details>

### b) JupyterLab in the browser

Click the **`jupyter-lab-…`** link. JupyterLab opens directly (no token), with
the workshop kernel already selected. In the file browser, open
`workshops/…/notebooks/` and run cells with **Shift+Enter**.

<details>
<summary>Prefer the command line? (Brev CLI)</summary>

```bash
brev port-forward <your-workspace-name> -p 8888:8888
# → open http://localhost:8888
```

</details>

### c) Your own local VS Code / Cursor

You can also drive the workspace from the VS Code or Cursor installed on your
laptop. It's a few more steps, but it works. _(If anything misbehaves, just use
the browser VS Code above - it's the same experience.)_

> **Note:** The workshop environment lives **inside a container** on your workspace, so
> your editor connects to the workspace and then **attaches to that container**.
> Each step below says _why_ it's there.

**Step 1 - Open your editor on the workspace.** From your **laptop terminal** (so
Brev wires up the SSH connection for you - don't type the host name into the
editor manually, it won't resolve):

```bash
brev open <your-workspace-name> cursor    # or:  brev open <your-workspace-name> code
```

_Why: this connects your editor to the workspace host over SSH._

**Step 2 - (Cursor only) one required setting.** Cursor's container-attach
crashes while copying your git config unless you turn that off. Open the Command
Palette (**Cmd/Ctrl + Shift + P**) → **"Preferences: Open User Settings (JSON)"**,
and add this line inside the `{ … }` (don't forget the **comma** if there are
other settings):

```json
"dev.containers.copyGitConfig": false
```

_Why: avoids a known Cursor bug - "Failed to read .gitconfig … path … undefined"._
_(VS Code users can skip this step.)_

<img src="https://raw.githubusercontent.com/quantum-device-consortium/qdw26-workshop-materials/main/docs/images/ide-open-settings.png" alt="User Settings (JSON) with copyGitConfig set to false" width="800" />

**Step 3 - Attach to the container.** Command Palette → **"Dev Containers: Attach
to Running Container…"** → pick the one ending in **`-dev-1`** (e.g.
`workspace-dev-1`).
_Why: this drops your editor inside the container, where the Python environment actually is._

<img src="https://raw.githubusercontent.com/quantum-device-consortium/qdw26-workshop-materials/main/docs/images/ide-attach-container.png" alt="Attach to Running Container - pick the container ending in -dev-1" width="800" />

**Step 4 - Open the materials.** In the new window, **File → Open Folder** →
`/home/ubuntu/qdw-workshop-materials`. Open a notebook under `workshops/…` and,
if prompted, choose the interpreter at
`/home/ubuntu/qdw-workshop-materials/.venv/bin/python`.

**Note:** `/home/ubuntu/qdw-workshop-materials/.venv/bin/python` is the python executable we use for this workshop

<img src="https://raw.githubusercontent.com/quantum-device-consortium/qdw26-workshop-materials/main/docs/images/ide-open-folder.png" alt="Materials folder opened inside the attached container" width="320" />

---

## 5 - GUI apps (KLayout, ParaView)

For the design project you may want desktop tools - **KLayout** to inspect a GDS
layout, or **ParaView** to view simulation fields. Your workspace includes a
lightweight Linux **desktop you open in a browser tab** (no X-server, nothing to
install).

1. On the **Access** page, click the **`no-vnc-desktop-…`** link (Using Secure
   Links). You'll land on a small "Directory listing" page - **click `vnc.html`**
   to open the desktop viewer:

   <img src="https://raw.githubusercontent.com/quantum-device-consortium/qdw26-workshop-materials/main/docs/images/novnc-landing.png" alt="noVNC landing page - click vnc.html" width="460" />

2. Click **Connect**. You'll get a desktop with a terminal already open.
3. **Open an app:** right-click the desktop background → **KLayout / ParaView /
   Terminal**, or type **`klayout`** in the terminal. In KLayout use
   _File → Open_ to load a `.gds` (export one from a notebook with
   `design.export_to_gds("my_chip.gds")` first).

<details>
<summary>Prefer the command line? (Brev CLI)</summary>

```bash
brev port-forward <your-workspace-name> -p 6080:6080
# → open http://localhost:6080/vnc.html  →  Connect
```

</details>

> The desktop has **KLayout** (layouts) and **ParaView** (fields/results)
> ready to go. Notebooks themselves render plots inline - you only need the
> desktop when you want a separate application window.

---

## 6 - Run everything locally with Docker (advanced)

<details>
<summary><b>Advanced & not recommended for the workshop</b> - run the whole stack on your own machine instead of the cloud. Click to expand.</summary>

Everything is a public repo + a prebuilt image, so you _can_ run it locally with
Docker Desktop and get the same JupyterLab / VS Code / desktop on `localhost`.

```bash
git clone https://github.com/quantum-device-consortium/qdw26-workshop-materials.git
cd qdw26-workshop-materials
docker compose -f compose.deploy.yaml pull
docker compose -f compose.deploy.yaml up -d
```

Then open: **JupyterLab** → <http://localhost:8888> · **VS Code** →
<http://localhost:8080> · **Desktop** → <http://localhost:6080/vnc.html>.

> ⚠️ **Apple Silicon (M-series) Macs:** the image is x86, so it runs under
> emulation. Layout/analysis is fine, but a **Palace simulation may crash with
> "Illegal instruction."** Fix: Docker Desktop → **Settings → General** →
> **uncheck "Use Rosetta for x86_64/amd64 emulation"** (use QEMU), Apply &
> Restart. Or just run the simulation notebooks on your Brev workspace.

Stop everything with `docker compose -f compose.deploy.yaml down`.

</details>

---

## 7 - Good to know

> ⚠️ **Pause your workspace between sessions** - _Stop_ it in
> the Brev console whenever you're not actively in a hands-on session.

### Saving your work for the long term

Your files persist while the workspace exists, but **don't treat the workspace as
permanent storage.** Before the workshop ends, download anything you want to keep
(or push it to your **own** Git repo).

<details>
<summary>How to download your work - for each way you connect</summary>

- **JupyterLab (8888):** right-click a file in the file browser → **Download**.
- **VS Code / code-server (8080):** right-click a file → **Download…**.
- **Brev CLI (whole folders):** from your laptop terminal -
  ```bash
  brev copy <your-workspace-name>:/home/ubuntu/qdw-workshop-materials/<your-file> ./
  ```
  _(`brev copy` reads from inside the container, where your work lives.)_
- **Bulk:** open a terminal (in Jupyter/VS Code/desktop) and zip first -
  `zip -r my_work.zip <folder>` - then download the single zip.

</details>

---

## 8 - Troubleshooting

| Symptom                                                           | Fix                                                                                                                                              |
| ----------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| A link won't load right after the workspace starts                | Give it ~30s to finish booting, then refresh.                                                                                                    |
| I'm being charged and I'm not even using it                       | The workspace bills while **running** - **Stop** it between sessions.                                                                            |
| Cursor attach: _"Could not resolve hostname …"_                   | Open via `brev open <name> cursor` from your terminal (don't type the host into "Connect to Host").                                              |
| Cursor attach: _"Failed to read .gitconfig … path … undefined"_   | Add `"dev.containers.copyGitConfig": false` to Cursor settings (JSON), then retry.                                                               |
| Editor shows only `/usr/bin/python3` / "ipykernel missing"        | Your editor is on the host, not the container - redo [4c step 3](#c-your-own-local-vs-code--cursor), or just use the browser VS Code.            |
| KLayout/GUI won't appear                                          | Use the **`6080` desktop** (section 5), not a notebook; right-click the desktop for the app menu.                                                |
| A simulation says _"not enough slots"_ or _"Illegal instruction"_ | On the Brev workspace this is already handled. Locally on Apple Silicon, see the [Docker note](#6---run-everything-locally-with-docker-advanced). |

**Still stuck?** Pleae create an [Issue]().

---

## For maintainers & contributors

Participants can stop here. The links below are for people building or deploying
the materials - they're kept in [`docs/`](https://github.com/quantum-device-consortium/qdw26-workshop-materials/tree/main/docs):

- **[docs/participant-quickstart.md](https://github.com/quantum-device-consortium/qdw26-workshop-materials/blob/main/docs/participant-quickstart.md)** - a longer, text-only version of this guide (AI generated).
- **[CONTRIBUTING.md](https://github.com/quantum-device-consortium/qdw26-workshop-materials/blob/main/CONTRIBUTING.md)** & **[docs/workshop-lead-guide.md](https://github.com/quantum-device-consortium/qdw26-workshop-materials/blob/main/docs/workshop-lead-guide.md)** - adding/updating workshop materials.
- **[docs/environment.md](https://github.com/quantum-device-consortium/qdw26-workshop-materials/blob/main/docs/environment.md)** & **[docs/brev.md](https://github.com/quantum-device-consortium/qdw26-workshop-materials/blob/main/docs/brev.md)** - the runtime image and the Brev launchable.
- **[docs/deployment-security.md](https://github.com/quantum-device-consortium/qdw26-workshop-materials/blob/main/docs/deployment-security.md)** & **[docs/access.md](https://github.com/quantum-device-consortium/qdw26-workshop-materials/blob/main/docs/access.md)** - security posture and access details.
- **[docs/gui-forwarding.md](https://github.com/quantum-device-consortium/qdw26-workshop-materials/blob/main/docs/gui-forwarding.md)** & **[docs/workspace-persistence.md](https://github.com/quantum-device-consortium/qdw26-workshop-materials/blob/main/docs/workspace-persistence.md)** - GUI forwarding and pause/resume internals.

<details>
<summary>Local dev quickstart (maintainers)</summary>

```bash
# build + run the full stack locally (auto-starts Jupyter 8888 / VS Code 8080 / desktop 6080)
docker compose up --build

# validate before a PR
python scripts/validate_workshops.py
python scripts/check_notebooks.py
docker compose -f compose.deploy.yaml config
```

</details>
