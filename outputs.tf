output "repository_url" {
  value = module.ecr.repository_url
}

output "primary_private_subnet" {
  value       = module.network.primary_private_subnet
  description = "Primary private subnet id"
}

output "secondary_private_subnet" {
  value       = module.network.secondary_private_subnet
  description = "Secondary private subnet id"
}

output "primary_private_subnet_cidr" {
  value       = module.network.primary_private_subnet_cidr
  description = "Primary private subnet cidr"
}

output "secondary_private_subnet_cidr" {
  value       = module.network.secondary_private_subnet_cidr
  description = "Secondary private subnet cidr"
}

output "primary_public_subnet_cidr" {
  value       = module.network.primary_public_subnet_cidr
  description = "Primary public subnet cidr"
}

output "secondary_public_subnet_cidr" {
  value       = module.network.secondary_public_subnet_cidr
  description = "Secondary public subnet cidr"
}

output "vpc_id" {
  value = module.network.vpc_id
}

output "availability_zones" {
  value = module.network.availability_zones
}

output "db_secret_arn" {
  value = module.aurora.secret_arn
}

output "database_name" {
  value = module.aurora.database_name
}

output "writer_endpoint" {
  value = module.aurora.writer_endpoint
}

output "reader_endpoint" {
  value = module.aurora.reader_endpoint
}

output "db_security_group" {
  value = module.network.db_security_group
}

output "web_app_security_group" {
  value = module.network.web_app_security_group
}

output "repository_arn" {
  value = module.ecr.repository_arn
}

output "load_balancer_target_group" {
  value = module.load_balancer.target_group
}
