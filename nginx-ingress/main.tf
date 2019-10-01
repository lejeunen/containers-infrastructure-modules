
terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}

  # The latest version of Terragrunt (v0.19.0 and above) requires Terraform 0.12.0 or above.
  required_version = ">= 0.12.0"
}

provider "helm" {
  version = "~> 0.10.0"
  install_tiller = true
  service_account = "tiller"
  namespace = "infra"

}
resource "helm_release" "nginx_ingress" {
  name  ="nginx-ingress"
  chart = "stable/nginx-ingress"
  namespace = var.app_namespace
  version = "0.26.0"


  values = [<<EOF
rbac:
  create: true
controller:
  service:
    type: NodePort
    annotations:
      kubernetes.io/ingress.class: nginx
    nodePorts:
      http: ${var.node_port}
    targetPorts:
      http: http
EOF
  ]

}

resource "kubernetes_ingress" "application" {
  metadata {
    name = "application-ingress"
    namespace = var.app_namespace
  }

  spec {

    rule {
      http {
        path {
          backend {
            service_name = "container1"
            service_port = 9000
          }

          path = "/container1/*"
        }

        path {
          backend {
            service_name = "container2"
            service_port = 9000
          }

          path = "/container2/*"
        }
      }
    }

  }
}