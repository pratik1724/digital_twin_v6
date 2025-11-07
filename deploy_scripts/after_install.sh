#!/bin/bash
set -e
echo "[AfterInstall] Installing dependencies"

# Backend (Python) setup
if [ -d /opt/digital_twin/backend ]; then
  cd /opt/digital_twin/backend
  # Create venv if not present
  if [ ! -d venv ]; then
    python3 -m venv venv
  fi
  source venv/bin/activate
  if [ -f requirements.txt ]; then
    pip install --upgrade pip
    pip install -r requirements.txt
  fi
  deactivate
fi

# Frontend: if static build not present, try to build (optional)
if [ -d /opt/digital_twin/frontend ]; then
  if [ -f /opt/digital_twin/frontend/package.json ]; then
    cd /opt/digital_twin/frontend
    # install and build (may need Node installed on EC2 if you want to build on instance)
    # npm ci && npm run build || true
    # assume CI built frontend; if not, you can add Node install steps earlier
    cd -
  fi
fi

echo "[AfterInstall] Done"
