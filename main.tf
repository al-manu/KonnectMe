
# ----------------------------------------
# Root Module Configuration
# ----------------------------------------

# AWS Provider Configuration
provider "aws" {
  region = var.region
}

# ----------------------------------------
# Redshift Module - Serverless Cluster
# ----------------------------------------
module "redshift" {
  source = "./modules/redshift"

  # General Configuration
  region               = var.region
  namespace_name       = var.namespace_name
  workgroup_name       = var.workgroup_name
  base_capacity        = var.base_capacity
  enhanced_vpc_routing = var.enhanced_vpc_routing
  log_exports          = var.log_exports

  # Networking and Security
  vpc_cidr             = var.vpc_cidr
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  allowed_ips          = var.allowed_ips

  # IAM Integration
  iam_role_name        = var.iam_role_name

  # Secrets Manager
  secret_name          = var.secret_name
  secret_description   = var.secret_description
  db_username          = var.db_username
  db_password          = var.db_password

  # Tags and Project Details
  tags                 = var.tags
  project_name         = var.project_name

  # Optional Parameters for Future Use
  # admin_username        = var.db_username    # Assuming db_username is the admin username
  # secret_arn            = aws_secretsmanager_secret.db_credentials.arn  # Use the secret ARN for password
  # vpc_security_group_id = aws_security_group.redshift.id  # Security group for Redshift
}


