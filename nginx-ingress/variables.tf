variable "app_namespace" {
  description = "The namespace where the module is deployed"
  default = "emasphere"
  type = string
}
variable "node_port" {
  description = "Port number to be used"
  type = string
}
