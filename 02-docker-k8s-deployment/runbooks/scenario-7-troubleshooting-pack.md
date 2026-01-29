# Scenario 7: Kubernetes troubleshooting pack (3 common incidents)

## Golden flow
1) kubectl get
2) kubectl describe
3) kubectl logs
4) kubectl events / probe failures

---

## Incident A: Running but Not Ready (readiness failing)
kubectl get pods -l app=sample-app
kubectl describe pod POD
kubectl logs POD
kubectl get endpoints sample-app -o wide

Common cause: missing config/secret/env required by readiness.

---

## Incident B: ErrImagePull / ImagePullBackOff
kubectl get pods -l app=sample-app
kubectl describe pod POD

Look for image pull errors in Events.

Minikube local image hint:
eval $(minikube docker-env)
docker build -t sample-app:local 02-docker-k8s-deployment/app/sample-app

---

## Incident C: CrashLoopBackOff
kubectl get pods -l app=sample-app
kubectl describe pod POD | tail -n 25
kubectl logs POD
kubectl logs POD --previous

Use --previous to capture logs from the last crashed container.
