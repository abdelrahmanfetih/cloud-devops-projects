# INC-003 — CreateContainerConfigError due to Secret key mismatch

## Symptoms
- Pod stuck in `CreateContainerConfigError`
- Pod never reaches Ready state

## Evidence
kubectl describe pod shows:
- `couldn't find key REQUIRED_TOKEN_WRONG in Secret sample-app-secret`

## Impact
- New pod cannot start
- Deployment rollout blocked
- Service remains on old pod only

## Root Cause
Deployment referenced a non-existent key in Kubernetes Secret:
- Requested: `REQUIRED_TOKEN_WRONG`
- Actual key: `REQUIRED_TOKEN`

## Diagnosis Steps
1. Check pod status:
   kubectl get pods -l app=sample-app
2. Describe failing pod:
   kubectl describe pod -l app=sample-app
3. Verify secret keys:
   kubectl get secret sample-app-secret -o yaml

## Fix
- Update Deployment to reference the correct secret key:
  `REQUIRED_TOKEN`
- Commit fix to Git
- Sync via Argo CD

## Verification
- Pod transitions to `Running`
- `kubectl get pods -l app=sample-app` shows `1/1 Running`

## Prevention
- Validate Secret keys during code review
- Avoid manual secret key changes
- Prefer config validation in CI where possible
