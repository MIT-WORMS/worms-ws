#!/bin/bash
set -e
git pull
if systemctl is-active --quiet worms-led-monitor; then
    sudo systemctl restart worms-led-monitor
fi
docker compose up -d --build --force-recreate
docker compose logs -f