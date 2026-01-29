# App choice: sample-app

## Why this app?
A minimal HTTP API that supports production-like Kubernetes practices:
- Separate liveness (`/healthz`) and readiness (`/readyz`)
- Readiness depends on configuration (`REQUIRED_TOKEN`)
- Clear structured logs for troubleshooting
- PORT configurable via env var

## Endpoints
- GET /        -> basic response
- GET /healthz -> liveness probe
- GET /readyz  -> readiness probe (503 if REQUIRED_TOKEN is missing)
