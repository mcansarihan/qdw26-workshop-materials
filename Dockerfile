# syntax=docker/dockerfile:1
FROM abhishekchak52/palace_env:latest

# Runtime libs for PySide6 / Qt6 (X11, xcb, GL/EGL, fonts) — common import failures without these.
RUN apt-get update && apt-get install -y \
	git \
    gmsh \
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


# Copy uv from astral-sh/uv:0.11.2
COPY --from=ghcr.io/astral-sh/uv:0.11.2 /uv /uvx /bin/

ENV UV_LINK_MODE=copy
# Put uv-managed Pythons in a shared location both root (build-time) and
# ubuntu (runtime, via the USER directive at the bottom) can read.
# ``UV_PYTHON_INSTALL_DIR`` is honoured by ``uv sync`` for the python lookup,
# AND uv sync will install Python here itself if it's missing — so we don't
# need a separate ``uv python install`` step.
ENV UV_PYTHON_INSTALL_DIR=/opt/uv-python

WORKDIR /home/ubuntu/qdw-workshop-materials

# Single step: sync installs both Python (if missing) AND project deps.
# We previously had a separate ``uv python install`` step but uv 0.11.x
# disagrees with itself about where that step puts Python vs where the
# subsequent ``uv sync`` looks for it (both ``UV_PYTHON_INSTALL_DIR`` env
# var and ``--install-dir`` flag were ignored by ``uv python install``,
# producing "Python interpreter not found at /opt/uv-python/...").
# Letting ``uv sync`` do the install in the same invocation as the lookup
# guarantees the two stay in agreement.
RUN --mount=type=cache,target=/home/ubuntu/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    --mount=type=bind,source=.python-version,target=.python-version \
    uv sync --locked --no-install-project

# Copy workshop materials after dependency installation so dependency layers stay cacheable.
COPY --chown=ubuntu:ubuntu . /home/ubuntu/qdw-workshop-materials

RUN chown -R ubuntu:ubuntu /home/ubuntu/qdw-workshop-materials /opt/uv-python

ENV PATH="/home/ubuntu/qdw-workshop-materials/.venv/bin:$PATH"


USER ubuntu
