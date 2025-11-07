#!/bin/bash
set -e
echo "[ApplicationStop] Stopping service if running"

if systemctl is-active --quiet digital_twin_backend.service; then
  systemctl stop digital_twin_backend.service || true
fi

echo "[ApplicationStop] Done"
