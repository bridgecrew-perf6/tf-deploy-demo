variable "base_cidr_block" {
  type = string
}

variable "vpc_name" {
  type    = string
  default = "main"
}

variable "public_subnet_required" {
  type    = bool
  default = false
}

variable "enable_web_app_access" {
  type    = bool
  default = false
}

variable "enable_postgresql_access" {
  type    = bool
  default = false
}
