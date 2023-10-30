## HELM

### Installation Instructions

https://helm.sh/docs/intro/install/

### Basic Helm Commands

Generate a helm boilerplate

```
helm create [chart name]
```

Linting

```
helm lint -f [values file]
```

Generate template

```
    helm template [release name] . -f [values file]
    
    helm template nginx . -f values-dev.yaml

```

Install Helm Chart

```
helm install [release name] . -f [values file] -n [namespace]

helm install nginx . -f values-dev.yaml -n dev
```



Upgrading Helm Chart

```
helm upgrade [release name] . -f [values file] -n [namespace]

helm upgrade nginx . -f values-dev.yaml -n dev
```

Uninstalling Helm Chart

```
helm uninstall [release name] -n [namespace]

helm uninstall nginx  -n dev
```

List helm charts

```
helm ls -n [namespace]

helm ls -n dev
```


Show helm chart release history

```
helm history [release name] -n [namespace]

helm history nginx -n dev
```

Rollback helm chart

```
helm rollback [release name] -n [namespace] [revision]

helm rollback nginx -n dev 1
```

