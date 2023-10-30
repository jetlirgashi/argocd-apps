# Namespaces

```
kubectl create namespace [name]
```

```
kubectl apply -f namespaces.yaml
kubectl delete -f namespaces.yaml


kubectl delete -f [filename]
kubectl get pods -n labs
kubectl get deployments -n labs
kubectl describe deployment [deployment name] -n labs
kubectl describe pod [pod name] -n labs
kubectl rollout restart deployment [deployment name] -n labs
kubectl port-forward svc/[service name] 8080:8080 -n labs
kubectl rollout undo deployment/[deployment name] -n labs


```
