
provider "aws" {
  region = var.region  # AWS region defined in variables.tf
}

# VPC Module - Ensure VPC is created first
# VPC Module - Ensure VPC is created first
module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = var.vpc_cidr_block
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones = var.availability_zones
  tags               = var.tags
  project_name       = var.project_name
  allowed_ips        = var.allowed_ips
}
# IAM Module - Role for Redshift
module "iam" {
  source        = "./modules/iam"
  iam_role_name = var.iam_role_name
  tags               = var.tags
}

# Secrets Manager Module - Store DB credentials in Secrets Manager
module "secrets_manager" {
  source         = "./modules/secrets_manager"
  secret_name    = var.secret_name
  secret_value   = var.db_password
  secret_description = var.secret_description
}

# Redshift Module - Redshift Serverless Configuration
module "redshift" {
  source           = "./modules/redshift"
  namespace_name   = var.namespace_name
  workgroup_name   = var.workgroup_name
  base_capacity    = var.base_capacity
  enhanced_vpc_routing = var.enhanced_vpc_routing
  log_exports      = var.log_exports
  db_username      = var.db_username
  db_password      = var.db_password
  db_host          = var.db_host
  db_port          = var.db_port
  db_name          = var.db_name
  iam_role_arn     = module.iam.iam_role_arn  # Referencing IAM role ARN
  vpc_security_group_id = module.vpc.vpc_security_group_id  # Referencing VPC security group
  tags             = var.tags
}
