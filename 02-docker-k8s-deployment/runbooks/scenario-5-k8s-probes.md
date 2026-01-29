# Scenario 5: Kubernetes probes (readiness vs liveness) + failure test

## Goal
Add readiness/liveness probes and observe Kubernetes behavior when readiness fails.

## Add probes
Update deployment.yaml with:
- readinessProbe: GET /readyz
- livenessProbe:  GET /healthz

Apply:
kubectl apply -f 02-docker-k8s-deployment/k8s/deployment.yaml

## Observe
kubectl get pods -l app=sample-app -o wide

## Failure test (readiness)
Remove REQUIRED_TOKEN from the Deployment env and apply again.
Expected:
- Pod stays Running
- READY becomes 0/1 for the failing pod

## Service routing proof
kubectl get endpoints sample-app -o wide
kubectl get endpointslice -l kubernetes.io/service-name=sample-app -o wide

## Access via service
kubectl port-forward service/sample-app 8080:80
curl -i http://127.0.0.1:8080/healthz
curl -i http://127.0.0.1:8080/readyz
