#!/bin/bash
set -e
REGION="us-east-1"      # <-- change to your region
# Basic packages
apt-get update -y
apt-get install -y ruby wget unzip python3 python3-venv python3-pip

# Install Node if you plan to build on instance or serve frontend (optional)
# curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
# apt-get install -y nodejs

# Install CodeDeploy agent (Ubuntu example)
cd /tmp
wget https://aws-codedeploy-${REGION}.s3.${REGION}.amazonaws.com/latest/install -O ./install
chmod +x ./install
./install auto || true

systemctl enable codedeploy-agent || true
systemctl start codedeploy-agent || true

# Create app dir and set ownership
mkdir -p /opt/digital_twin
chown -R ubuntu:ubuntu /opt/digital_twin
