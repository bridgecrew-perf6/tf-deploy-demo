locals {
  environment       = "sandbox"
  project_name      = "terraform"
  domain_name       = "terraform-sandbox.example.com"
  deployment_region = "us-west-2"
  repository_name   = "tf-demo-app"
}

provider "aws" {
  region  = local.deployment_region
  profile = "deployment"
}

# Required for making globally available certificates
provider "aws" {
  alias   = "virginia"
  region  = "us-east-1"
  profile = "deployment"
}

module "ecs" {
  source = "./modules/ecs-web-app"
  environment_variables = {
    DB_WRITER_HOST = module.aurora.writer_endpoint,
    DB_READER_HOST = module.aurora.reader_endpoint,
    DB_NAME        = module.aurora.database_name,
  }
  secrets = {
    POSTGRES_USERNAME = "${module.aurora.secret_arn}:username::",
    POSTGRES_PASSWORD = "${module.aurora.secret_arn}:password::",
  }
  environment                = local.environment
  project_name               = local.project_name
  vpc_id                     = module.network.vpc_id
  repository_url             = module.ecr.repository_url
  app_subnets                = [module.network.primary_private_subnet, module.network.secondary_private_subnet]
  app_security_groups        = [module.network.web_app_security_group]
  load_balancer_target_group = module.load_balancer.target_group
}

module "load_balancer" {
  source                        = "./modules/app-load-balancer"
  load_balancer_subnets         = [module.network.primary_public_subnet, module.network.secondary_public_subnet]
  load_balancer_security_groups = [module.network.load_balancer_security_group]
  project_name                  = local.project_name
  environment                   = local.environment
  load_balancer_certificate_arn = aws_acm_certificate.lb_cert.arn
  vpc_id                        = module.network.vpc_id
}
module "cloudfront" {
  source             = "./modules/cloudfront"
  origin_domain_name = module.load_balancer.dns_name
  domain_name        = local.domain_name
  certificate_arn    = aws_acm_certificate.cloudfront_cert.arn
  environment        = local.environment
  project_name       = local.project_name
}
module "network" {
  source                   = "./modules/aws-network"
  vpc_name                 = "${local.project_name}-${local.environment}"
  base_cidr_block          = "10.250.0.0/16"
  public_subnet_required   = true
  enable_web_app_access    = true
  enable_postgresql_access = true
}

module "aurora" {
  source             = "./modules/rds-aurora"
  vpc_name           = module.network.vpc_name
  database_name      = "${local.project_name}_${local.environment}"
  cluster_name       = "${local.project_name}-${local.environment}-cluster"
  availability_zones = module.network.availability_zones
  security_groups    = [module.network.db_security_group]
  subnet_ids         = [module.network.primary_private_subnet, module.network.secondary_private_subnet]
}

module "ecr" {
  source          = "./modules/aws-container-registry"
  repository_name = "${local.project_name}-${local.environment}"
  mutability      = "MUTABLE"
}
