variable "repository_name" {
    type = string
    default = "main"
}

variable "scan_on_push" {
    type = bool
    default = true
}

variable "mutability" {
    type = string
    default = "IMMUTABLE"
}