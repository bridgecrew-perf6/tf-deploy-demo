variable "availability_zones" {
  type = list(string)
}

variable "database_name" {
  type = string
}

variable "username" {
  type    = string
  default = "example"
}

variable "cluster_name" {
  type = string
}

variable "engine_version" {
  type    = string
  default = "13.4"
}

variable "instance_count" {
  type    = number
  default = 2
}

variable "instance_class" {
  type    = string
  default = "db.t4g.medium"
}

variable "vpc_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}
