#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="01-linux-git-foundations/artifacts"
OUT_FILE="${OUT_DIR}/incident_log.txt"

mkdir -p "$OUT_DIR"
echo "$(date) - log entry" >> "$OUT_FILE"
echo "Wrote: $OUT_FILE"
