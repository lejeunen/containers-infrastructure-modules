
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
resource "helm_release" "dashboard" {
  name = "dashboard"
  chart = "stable/kubernetes-dashboard"
  namespace = "kube-system"
  version = "0.8.0"
  keyring = ""


  set {
    name = "rbac.create"
    value = true
  }
}