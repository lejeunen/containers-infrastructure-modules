# nginx-ingress

Deploys an nginx ingress of type _NodePort_
https://github.com/helm/charts/tree/master/stable/nginx-ingress

And a kubernetes ingress for path based routing to container 1 or container 2


See https://kubernetes.io/docs/concepts/services-networking/service/#nodeport

*Each node proxies that port (the same port number on every Node) into your Service*

Therefore it doesn't matter on which worker node the ingress controller is deployed.
