#!/bin/bash
set -e
git pull
docker compose up -d --build --force-recreate
docker compose logs -f