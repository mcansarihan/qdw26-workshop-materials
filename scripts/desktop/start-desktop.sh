#!/usr/bin/env bash
# Fluxbox session for the workshop noVNC desktop.
# Sets a background, opens a welcome terminal so the desktop is never an empty
# black screen, then hands off to the window manager. Run by supervisor.
export DISPLAY=:1

# Wait for the X server (:1) to accept connections.
for _ in $(seq 1 100); do
  xset q >/dev/null 2>&1 && break
  sleep 0.2
done

# Solid background (no scary pure-black screen).
xsetroot -solid "#1f2335" 2>/dev/null || true

# Open one welcome terminal in the materials directory, shortly after the WM is up.
(
  sleep 1
  xterm -fa Monospace -fs 12 -geometry 104x28+40+40 -title "QDW Terminal" -e bash -lc '
    cd /home/ubuntu/qdw-workshop-materials
    echo
    echo "  ===== QDW Workshop desktop ====="
    echo "  • Right-click the background for KLayout / Terminal / ParaView"
    echo "  • Or just type a command here, e.g.:   klayout"
    echo "  • Open a layout:                        klayout your_design.gds"
    echo
    exec bash'
) &

exec fluxbox
