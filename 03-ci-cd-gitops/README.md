# Project 3 — CI/CD & GitOps (Production-Oriented)

## Overview
This project demonstrates a production-oriented DevOps workflow that connects:
- CI pipelines
- Container image builds
- GitOps-based Kubernetes deployments
- Real incident handling with documented runbooks

The focus is not on tools alone, but on **understanding system behavior, failure modes, and recovery**.

---

## Architecture
- **CI**: GitHub Actions
- **Container Registry**: GitHub Container Registry (GHCR)
- **Orchestration**: Kubernetes (Minikube)
- **GitOps**: Argo CD
- **Source of Truth**: Git (no manual kubectl apply in production path)

---

## CI Pipeline
Implemented a CI pipeline that:
1. Builds Docker images from application source
2. Runs a smoke test inside the container
3. Pushes images to GHCR with:
   - Commit SHA tag
   - `latest` tag

**Key behavior**
- Build failures block deployment
- Images are immutable and traceable to commits

---

## GitOps Deployment (Argo CD)
- Kubernetes manifests are deployed via Argo CD
- Argo CD continuously reconciles:
  - Desired state (Git)
  - Actual state (Cluster)

Manual deployments are avoided; all changes flow through Git.

---

## Implemented Incidents & Runbooks

### INC-002 — ImagePullBackOff
**Scenario**
- Deployment referenced a non-existent image tag

**Impact**
- Pods failed with `ErrImagePull` / `ImagePullBackOff`

**Resolution**
- Corrected image reference to GHCR image built by CI
- Synced via Argo CD

---

### INC-003 — CreateContainerConfigError (Secret mismatch)
**Scenario**
- Deployment referenced a missing key in a Kubernetes Secret

**Impact**
- Pods stuck in `CreateContainerConfigError`
- Rollout blocked

**Resolution**
- Fixed secret key reference in Deployment
- Synced via Argo CD
- Documented recovery steps in runbook

---

## Security & Configuration Practices
- Sensitive values moved from hardcoded manifests to Kubernetes Secrets
- Deployments reference secrets via `valueFrom`
- Changes tracked and audited via Git history

---

## Key Takeaways
- CI and GitOps are tightly coupled
- Git is the single source of truth
- Failures are expected and handled via structured troubleshooting
- Runbooks document real incidents, not theoretical examples

---

## Repository Structure
03-ci-cd-gitops/
├── README.md
├── runbooks/
│ ├── INC-002-imagepullbackoff.md
│ └── INC-003-secret-key-mismatch.md
├── notes/
└── scripts/
