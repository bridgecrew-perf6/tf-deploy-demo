
output "availability_zones" {
  value       = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  description = "Avaiability zones for configured vpc"
}

output "primary_private_subnet" {
  value       = aws_subnet.private[0].id
  description = "Primary private subnet id"
}

output "secondary_private_subnet" {
  value       = aws_subnet.private[1].id
  description = "Secondary private subnet id"
}

output "primary_public_subnet" {
  value       = var.public_subnet_required ? aws_subnet.public[0].id : ""
  description = "Primary public subnet id"
}

output "secondary_public_subnet" {
  value       = var.public_subnet_required ? aws_subnet.public[1].id : ""
  description = "Secondary public subnet id"
}

output "primary_private_subnet_cidr" {
  value       = aws_subnet.private[0].cidr_block
  description = "Primary private subnet id"
}

output "secondary_private_subnet_cidr" {
  value       = aws_subnet.private[1].cidr_block
  description = "Secondary private subnet id"
}

output "primary_public_subnet_cidr" {
  value       = var.public_subnet_required ? aws_subnet.public[0].cidr_block : ""
  description = "Primary public subnet id"
}

output "secondary_public_subnet_cidr" {
  value       = var.public_subnet_required ? aws_subnet.public[1].cidr_block : ""
  description = "Secondary public subnet id"
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC ID"
}

output "vpc_name" {
  value = var.vpc_name
}

output "db_security_group" {
  value = var.enable_postgresql_access ? aws_security_group.database[0].id : ""
}

output "load_balancer_security_group" {
  value = var.enable_web_app_access ? aws_security_group.load_balancer[0].id : ""
}

output "web_app_security_group" {
  value = var.enable_web_app_access ? aws_security_group.web_app[0].id : ""
}
