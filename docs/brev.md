# Brev

Brev can host the same repository and Docker Compose environment used locally.

## Cost Check

Before provisioning, check available instance types and pricing:

```bash
brev search cpu --json
brev search gpu --json
```

Use a low-cost or credited instance for setup testing. Larger instances can be selected later for attendee load.

## Start A Workspace

The setup script clones this repository and starts Docker Compose:

```bash
brev create qdw-workshop-materials \
  --type cpu-d3.16vcpu-64gb \
  --startup-script @scripts/brev-clone-and-setup.sh
```

Open the instance using the path that fits the workshop:

```bash
brev open qdw-workshop-materials
brev open qdw-workshop-materials code
brev open qdw-workshop-materials cursor
```

SSH is also supported through the Brev CLI.

## After Login

```bash
cd qdw-workshop-materials
docker compose ps
docker compose exec dev bash
```

JupyterLab, editor attachment, SSH, and terminal access all use the same running environment.
