# Scenario 6: Recovery rollout (make pods Ready again)

## Goal
Restore a healthy/ready state after a readiness failure by reintroducing required configuration.

## Change
Add REQUIRED_TOKEN back to the Deployment env.

## Apply + verify
kubectl apply -f 02-docker-k8s-deployment/k8s/deployment.yaml
kubectl rollout status deployment/sample-app
kubectl get pods -l app=sample-app

## Verify service routing
kubectl get endpoints sample-app -o wide
