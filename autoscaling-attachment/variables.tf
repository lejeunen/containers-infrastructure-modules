variable "autoscaling_group_name" {
  description = "The name of the EKS workers auto scaling group"
  type        = string
}

variable "alb_target_group_arn" {
  description = "The ARN of the target group created by the ALB"
  type        = string
}
