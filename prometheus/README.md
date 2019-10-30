# prometheus

See https://github.com/helm/charts/tree/master/stable/prometheus

```
$ export POD_NAME=$(kubectl get pods --namespace infra -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
$ kubectl --namespace infra port-forward $POD_NAME 9090
```

Console : http://localhost:9090
