# Runbook: Health Check Script

## Purpose
Generate a timestamped health report for common ops signals:
- Disk usage
- Memory usage
- Docker status (containers running)
- Kubernetes status (cluster reachable, nodes Ready)

## How to run
From repo root:
- `./01-linux-git-foundations/scripts/health_check.sh`

## Output
Reports are written to:
- `01-linux-git-foundations/artifacts/health-reports/health-YYYYMMDD-HHMMSS.txt`

## How to interpret
### Disk
- Use% >= 80%: warning
- Use% >= 90%: critical

### Memory
- Focus on "available" memory (not only "free")
- Swap usage rising can indicate memory pressure

### Docker
- If only header appears: Docker is running but no containers are running
- If "Docker installed but not running": start Docker / check WSL integration

### Kubernetes
- If cluster-info fails: cluster may be down (e.g., minikube stopped)
- `kubectl get nodes` should show nodes as Ready
