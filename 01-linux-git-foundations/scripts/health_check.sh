#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR="01-linux-git-foundations/artifacts/health-reports"
TS="$(date +%Y%m%d-%H%M%S)"
REPORT_FILE="${REPORT_DIR}/health-${TS}.txt"

mkdir -p "$REPORT_DIR"

echo "=== HEALTH CHECK REPORT ===" > "$REPORT_FILE"
echo "Timestamp: $(date)" >> "$REPORT_FILE"
echo "Host: $(hostname)" >> "$REPORT_FILE"
echo >> "$REPORT_FILE"
echo "=== DISK USAGE ===" >> "$REPORT_FILE"
df -h >> "$REPORT_FILE"
echo >> "$REPORT_FILE"
echo "=== MEMORY USAGE ===" >> "$REPORT_FILE"
free -h >> "$REPORT_FILE"
echo >> "$REPORT_FILE"
echo "=== DOCKER STATUS ===" >> "$REPORT_FILE"

if command -v docker >/dev/null 2>&1; then
  docker ps >> "$REPORT_FILE" 2>&1 || echo "Docker installed but not running" >> "$REPORT_FILE"
else
  echo "Docker not installed" >> "$REPORT_FILE"
fi

echo >> "$REPORT_FILE"
echo "=== KUBERNETES STATUS ===" >> "$REPORT_FILE"

if command -v kubectl >/dev/null 2>&1; then
  kubectl cluster-info >> "$REPORT_FILE" 2>&1 || echo "kubectl installed but cluster not reachable" >> "$REPORT_FILE"
  echo "--- nodes ---" >> "$REPORT_FILE"
  kubectl get nodes >> "$REPORT_FILE" 2>&1 || true
else
  echo "kubectl not installed" >> "$REPORT_FILE"
fi

echo >> "$REPORT_FILE"
