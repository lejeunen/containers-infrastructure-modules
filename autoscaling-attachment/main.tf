provider "aws" {
  region = var.aws_region
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}

  # The latest version of Terragrunt (v0.19.0 and above) requires Terraform 0.12.0 or above.
  required_version = ">= 0.12.0"
}

resource "aws_autoscaling_attachment" "asg_attachment_eks" {
  autoscaling_group_name = var.autoscaling_group_name
  alb_target_group_arn   = var.alb_target_group_arn
}