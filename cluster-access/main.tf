
terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}

  # The latest version of Terragrunt (v0.19.0 and above) requires Terraform 0.12.0 or above.
  required_version = ">= 0.12.0"
}
provider "aws" {
  region = var.aws_region
}

resource "kubernetes_role" "namespace-full-access" {
  metadata {
    name = "namespace-full-access"
    namespace = var.app_namespace
  }

  rule {
    api_groups     = [""]
    resources      = ["*"]
    verbs          = ["*"]
  }
}

resource "kubernetes_role_binding" "namespace-full-access-binding" {
  metadata {
    name      = "namespace-full-access-binding"
    namespace = var.app_namespace
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "namespace-full-access"
  }
  subject {
    kind      = "User"
    name      = var.username
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "aws_iam_role" "role_developer" {
  name = "role-developer"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.aws_account}:root"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    "containers/terraform" = "true"
  }
}

resource "aws_iam_role" "role_admin" {
  name = "role_admin"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.aws_account}:root"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    "containers/terraform" = "true"
  }
}

resource "aws_iam_policy" "developer_role_policy" {
  name        = "developer-role-policy"
  description = "Allows to assume the developer-role"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": {
        "Effect": "Allow",
        "Action": "sts:AssumeRole",
        "Resource": "arn:aws:iam::${var.aws_account}:role/${aws_iam_role.role_developer.name}"
    }
}
EOF

}

resource "aws_iam_policy" "admin_role_policy" {
  name        = "admin-role-policy"
  description = "Allows to assume the admin-role"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": {
        "Effect": "Allow",
        "Action": "sts:AssumeRole",
        "Resource": "arn:aws:iam::${var.aws_account}:role/${aws_iam_role.role_admin.name}"
    }
}
EOF

}