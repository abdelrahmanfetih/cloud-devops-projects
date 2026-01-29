# Scenario 4: Kubernetes deployment + service + port-forward

## Goal
Deploy the app to minikube and access it via a ClusterIP Service.

## Prereqs
- minikube running
- Image available to minikube runtime (if using local images, build inside minikube)

## Deploy
kubectl apply -f 02-docker-k8s-deployment/k8s/deployment.yaml

## Create Service
kubectl apply -f 02-docker-k8s-deployment/k8s/service.yaml
kubectl get svc sample-app

## Verify pod
kubectl get pods
kubectl logs deployment/sample-app

## Access (port-forward)
kubectl port-forward service/sample-app 8080:80

## Validate
curl -i http://127.0.0.1:8080/healthz   # expect 200
curl -i http://127.0.0.1:8080/readyz    # expect 200 (REQUIRED_TOKEN set in Deployment)

## Troubleshooting
### ErrImagePull / ImagePullBackOff
If the image tag is local (e.g., sample-app:local), minikube may not see it.
Fix (in the current terminal):
  eval $(minikube docker-env)
  docker build -t sample-app:local 02-docker-k8s-deployment/app/sample-app
  kubectl rollout restart deployment/sample-app
