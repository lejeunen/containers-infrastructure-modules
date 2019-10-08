
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

data "helm_repository" "containers" {
  name = "containers"
  url  = "https://raw.githubusercontent.com/lejeunen/containers-infrastructure-charts/master/repository/"
}

resource "helm_release" "module2" {
  name = "module2"
  repository = "${data.helm_repository.containers.metadata.0.name}"
  chart = "container2"
  version = "0.1.3"

  namespace = var.app_namespace


  set {
    name = "image.tag"
    value = "latest"
  }

  set {
    name = "image.repository"
    value = "lejeunen/container2"
  }
}