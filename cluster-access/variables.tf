variable "app_namespace" {
  description = "The namespace for the role"
  default = "emasphere"
  type = string
}
variable "username" {
  description = "The name of the user receiving full access to the namespace. Case sensitive."
  default = "developer"
  type = string
}
variable "aws_account" {
  description = "The AWS account number where roles and policies must be created"
  type = string
}
variable "aws_region" {
  description = "The AWS region to deploy to (e.g. eu-central-1)"
  type = string
  default = "eu-central-1"
}