#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT_PATH="$REPO_DIR/deploy/docker_monitor.py"
SERVICE_PATH="/etc/systemd/system/worms-docker-monitor.service"

# Write the service file
sudo tee "$SERVICE_PATH" > /dev/null <<EOF
[Unit]
Description=WORMS Docker Monitor
After=docker.service
Requires=docker.service

[Service]
Type=simple
ExecStart=/usr/bin/python3 $SCRIPT_PATH
Restart=always
RestartSec=5
User=root

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable worms-docker-monitor
sudo systemctl start worms-docker-monitor

sudo systemctl status worms-docker-monitor --no-pager