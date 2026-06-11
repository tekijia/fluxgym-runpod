#!/bin/bash
set -e

cd /workspace

echo "Starting FileBrowser..."
filebrowser \
  --address 0.0.0.0 \
  --port 8080 \
  --root /workspace \
  --noauth &

echo "Starting JupyterLab..."
jupyter lab \
  --ip=0.0.0.0 \
  --port=8888 \
  --allow-root \
  --no-browser \
  --ServerApp.token='' \
  --ServerApp.password='' &

if [ -d "/workspace/fluxgym" ]; then
  echo "Starting FluxGym..."
  cd /workspace/fluxgym
  source venv/bin/activate
  python app.py
else
  echo "FluxGym not found at /workspace/fluxgym"
  echo "Debug mode"
  tail -f /dev/null
fi
