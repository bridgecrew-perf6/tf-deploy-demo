variable "load_balancer_subnets" {
  type = list(any)
}

variable "load_balancer_security_groups" {
  type = list(any)
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "load_balancer_certificate_arn" {
  type = string
}

variable "vpc_id" {
  type = string
}
