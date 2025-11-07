#!/bin/bash
set -e
echo "[ApplicationStart] Starting application"

# Create systemd service for backend (assumes Gunicorn and FastAPI app: app:app)
cat >/etc/systemd/system/digital_twin_backend.service <<'EOF'
[Unit]
Description=Digital Twin Backend (Gunicorn)
After=network.target

[Service]
User=ubuntu
Group=ubuntu
WorkingDirectory=/opt/digital_twin/backend
ExecStart=/opt/digital_twin/backend/venv/bin/gunicorn --workers 3 --bind 0.0.0.0:8000 app:app
Restart=always
Environment=PYTHONUNBUFFERED=1

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable digital_twin_backend.service
systemctl restart digital_twin_backend.service || true

echo "[ApplicationStart] Done"
