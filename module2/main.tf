
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


resource "helm_release" "module2" {
  name = "module2"
  # TODO get chart from repository
  chart = "../../../../../../../../../containers/helm/container2"
  namespace = var.app_namespace

  # chart version is constant because versionning is performed at git level.
  # containers-infrastructure-environments refers to this repository with a git tag
  version = "0.1.0"

  set {
    name = "image.tag"
    value = "latest"
  }

  set {
    name = "image.repository"
    value = "lejeunen/container2"
  }
}