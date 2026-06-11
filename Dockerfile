# syntax=docker/dockerfile:1
FROM abhishekchak52/palace_env:latest

ENV PALACE_BIN=/opt/qdw/bin/palace
RUN set -eux; \
    palace_path="$(command -v palace)"; \
    test -x "$palace_path"; \
    mkdir -p "$(dirname "$PALACE_BIN")"; \
    printf '#!/usr/bin/env bash\nexec "%s" "$@"\n' "$palace_path" > "$PALACE_BIN"; \
    chmod +x "$PALACE_BIN"; \
    test -x "$PALACE_BIN"; \
    runuser -u ubuntu -- "$PALACE_BIN" --version

# Runtime libs for PySide6 / Qt6 (X11, xcb, GL/EGL, fonts) — common import failures
# without these — plus a lightweight in-browser desktop (TigerVNC + fluxbox + noVNC)
# so attendees can open GUI apps (KLayout, the Qiskit Metal GUI) from a browser tab
# during the design project without any local X server. Managed by supervisor.
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	git \
	curl \
	ca-certificates \
    gmsh \
	klayout \
	paraview \
	python3-paraview \
	supervisor \
	tigervnc-standalone-server \
	tigervnc-common \
	fluxbox \
	novnc \
	websockify \
	xterm \
	x11-xserver-utils \
	dbus-x11 \
	libdbus-1-3 \
	libdrm2 \
	libegl1 \
	libfontconfig1 \
	libfreetype6 \
	libgbm1 \
	libgl1 \
	libgl1-mesa-dri \
	libglib2.0-0 \
	libgles2 \
	libglu1-mesa \
	libice6 \
	libopengl0 \
	libsm6 \
	libx11-6 \
	libx11-xcb1 \
	libxcb-cursor0 \
	libxcb-icccm4 \
	libxcb-image0 \
	libxcb-keysyms1 \
	libxcb-randr0 \
	libxcb-render0 \
	libxcb-render-util0 \
	libxcb-shape0 \
	libxcb-shm0 \
	libxcb-sync1 \
	libxcb-xfixes0 \
	libxcb-xinerama0 \
	libxcb1 \
	libxext6 \
	libxi6 \
	libxkbcommon0 \
	libxkbcommon-x11-0 \
	libxrender1 \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# code-server: VS Code in the browser, running INSIDE the container. This is the
# robust "use your own IDE" path on hosted launchables — attendees open a browser
# tab and get full VS Code with the workshop environment already selected, with
# no SSH, no "attach to container", and no docker-group issues.
RUN curl -fsSL https://code-server.dev/install.sh | sh


# Copy uv from astral-sh/uv:0.11.2
COPY --from=ghcr.io/astral-sh/uv:0.11.2 /uv /uvx /bin/

ENV UV_LINK_MODE=copy
ENV UV_PYTHON_DOWNLOADS=automatic
ENV UV_PYTHON_INSTALL_DIR=/opt/qdw/uv-python

WORKDIR /home/ubuntu/qdw-workshop-materials

# Keep uv-managed Python outside /root so the runtime ubuntu user can execute
# the virtualenv interpreter without broadening root directory permissions.
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    --mount=type=bind,source=.python-version,target=.python-version \
    uv python install \
    && python_path="$(uv python find --managed-python --no-project "$(cat .python-version)")" \
    && uv sync --locked --no-install-project --python "$python_path"
# NOTE: debugpy is intentionally kept (it ships transitively via ipykernel). It is
# what lets attendees set breakpoints / use the VS Code & Cursor debuggers against
# the kernel in this container, so it must NOT be uninstalled.

# Copy workshop materials after dependency installation so dependency layers stay cacheable.
COPY --chown=ubuntu:ubuntu . /home/ubuntu/qdw-workshop-materials

RUN chown -R ubuntu:ubuntu /home/ubuntu/qdw-workshop-materials \
 && chmod -R a+rX /opt/qdw/uv-python \
 && runuser -u ubuntu -- /home/ubuntu/qdw-workshop-materials/.venv/bin/python -c "import matplotlib.font_manager as fm; fm._load_fontmanager(try_read_cache=False)"

# Pre-configure code-server for the ubuntu user: install the Python + Jupyter
# extensions (from Open VSX) and point the interpreter at the workshop venv so
# the browser IDE is ready with zero setup. Extension installs are best-effort so
# a transient Open VSX hiccup never fails the image build.
# Note: runuser keeps HOME=/root, so we set HOME=/home/ubuntu explicitly and make
# the whole ~/.local tree ubuntu-owned, otherwise code-server writes its data dir
# as root and the extension install fails with EACCES.
RUN mkdir -p /home/ubuntu/.local/share/code-server/User \
 && cp /home/ubuntu/qdw-workshop-materials/scripts/desktop/code-server-settings.json \
       /home/ubuntu/.local/share/code-server/User/settings.json \
 && chown -R ubuntu:ubuntu /home/ubuntu/.local \
 && (runuser -u ubuntu -- env HOME=/home/ubuntu code-server --install-extension ms-python.python || echo "WARN: ms-python.python not installed") \
 && (runuser -u ubuntu -- env HOME=/home/ubuntu code-server --install-extension ms-toolsai.jupyter || echo "WARN: ms-toolsai.jupyter not installed")

ENV PATH="/home/ubuntu/qdw-workshop-materials/.venv/bin:$PATH"
ENV PYTHONPATH="/home/ubuntu/qdw-workshop-materials/shared/python"

# MPI oversubscription backstop. palace_cpu_count() already defaults to the
# physical-core count so Palace fits the available MPI slots; this env var means
# that even if someone sets QDW_PALACE_CPUS higher than the core count, MPI
# time-shares instead of hard-failing with "not enough slots available".
# (Verified on the OpenMPI 5 / PRRTE build used here; the OpenMPI 4 variable is
# a no-op on this version.)
ENV PRTE_MCA_rmaps_default_mapping_policy=:oversubscribe

# Make the IDE experience plug-and-play. When a participant runs VS Code / Cursor
# "Dev Containers: Attach to Running Container", this label is read automatically:
# it installs the Python + Jupyter extensions and pre-selects the workshop venv as
# the interpreter/kernel — so no manual environment selection is ever needed.
LABEL devcontainer.metadata='[{"remoteUser":"ubuntu","workspaceFolder":"/home/ubuntu/qdw-workshop-materials","customizations":{"vscode":{"extensions":["ms-python.python","ms-toolsai.jupyter"],"settings":{"python.defaultInterpreterPath":"/home/ubuntu/qdw-workshop-materials/.venv/bin/python","python.terminal.activateEnvironment":false,"jupyter.kernels.filter":[]}}}}]'

USER ubuntu
ENTRYPOINT ["/home/ubuntu/qdw-workshop-materials/scripts/container-entrypoint.sh"]
