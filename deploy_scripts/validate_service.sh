#!/bin/bash
set -e
echo "[ValidateService] Checking health endpoint"

# Retry with small timeout
COUNT=0
MAX=12
SLEEP=5

until [ $COUNT -ge $MAX ]
do
  if curl -sSf http://127.0.0.1:8000/health >/dev/null 2>&1; then
    echo "[ValidateService] Health OK"
    exit 0
  fi
  COUNT=$((COUNT+1))
  echo "[ValidateService] attempt ${COUNT}/${MAX} failed, sleeping ${SLEEP}s..."
  sleep $SLEEP
done

echo "[ValidateService] Service did not become healthy"
exit 1
