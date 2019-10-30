# grafana

See https://github.com/helm/charts/tree/master/stable/grafana

```
$ kubectl get secret --namespace infra grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
$ export POD_NAME=$(kubectl get pods --namespace infra -l "app=grafana" -o jsonpath="{.items[0].metadata.name}")
$ kubectl --namespace infra port-forward $POD_NAME 3000
```

Console : http://localhost:3000

Sample dashboards to get started
https://grafana.com/grafana/dashboards/6336
https://grafana.com/grafana/dashboards/6417
https://grafana.com/grafana/dashboards/315

