#!/bin/bash
set -e
echo "[BeforeInstall] Starting"

# create app dir if missing
mkdir -p /opt/digital_twin
chown -R ubuntu:ubuntu /opt/digital_twin || true

# backup existing app
if [ -d /opt/digital_twin/backend ]; then
  ts=$(date +%s)
  mv /opt/digital_twin/backend /opt/digital_twin/backup/backend_${ts} || true
fi
if [ -d /opt/digital_twin/frontend ]; then
  ts=$(date +%s)
  mv /opt/digital_twin/frontend /opt/digital_twin/backup/frontend_${ts} || true
fi

echo "[BeforeInstall] Done"
