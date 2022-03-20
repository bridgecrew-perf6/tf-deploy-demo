variable "cpu" {
  type    = number
  default = 512
}

variable "memory" {
  type    = number
  default = 1024
}

variable "environment_variables" {
  type    = map(any)
  default = {}
}

variable "secrets" {
  type    = map(any)
  default = {}
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "repository_url" {
  type = string
}

variable "app_subnets" {
  type = list(any)
}
variable "app_security_groups" {
  type = list(any)
}

variable "vpc_id" {
  type = string
}

variable "load_balancer_target_group" {
  type = string
}

variable "task_runner_command" {
  type    = list(any)
  default = []
}

variable "instance_count" {
  type    = number
  default = 2
}
