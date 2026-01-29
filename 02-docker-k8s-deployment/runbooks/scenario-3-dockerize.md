# Scenario 3: Dockerize the app + validate health/readiness

## Goal
Build a Docker image for the app and validate that health/readiness behavior matches local runs.

## Build
docker build -t sample-app:local 02-docker-k8s-deployment/app/sample-app

## Run (no REQUIRED_TOKEN -> readiness should fail)
docker run --rm -p 8080:8080 sample-app:local

### Validate
curl -i http://127.0.0.1:8080/healthz   # expect 200
curl -i http://127.0.0.1:8080/readyz    # expect 503

## Run (with REQUIRED_TOKEN -> readiness should succeed)
docker run --rm -e REQUIRED_TOKEN=dev -p 8080:8080 sample-app:local

### Validate
curl -i http://127.0.0.1:8080/readyz    # expect 200

## Notes
- `python:3.10-slim` is an image name used in the Dockerfile `FROM`, not a shell command.
