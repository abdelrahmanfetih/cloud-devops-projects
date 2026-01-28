#!/usr/bin/env bash
set -euo pipefail

LOG_DIR="01-linux-git-foundations/artifacts"
LOG_FILE="${LOG_DIR}/fake_service.log"

mkdir -p "$LOG_DIR"

R=$((RANDOM % 5))

if [[ "$R" -eq 0 ]]; then
  echo "$(date) ERROR failed to connect to database" >> "$LOG_FILE"
  exit 1
elif [[ "$R" -eq 1 ]]; then
  echo "$(date) WARN high memory usage detected" >> "$LOG_FILE"
else
  echo "$(date) INFO service running normally" >> "$LOG_FILE"
fi
