# # Define the module for creating S3 buckets
# module "s3_buckets" {
#   source = "./modules/S3"  # Path to the S3 module
  
#   # Pass the required variables to the module (from dev.tfvars, prod.tfvars, etc.)
#   in_bucket_name     = var.in_bucket_name
#   out_bucket_name    = var.out_bucket_name
#   tmp_bucket_name    = var.tmp_bucket_name
#   export_bucket_name = var.export_bucket_name
# }




# # Module to deploy Redshift Serverless

# # main.tf (Root Module)
# main.tf - Root configuration for your project

# provider "aws" {
#   region = "eu-central-1"  # Specify the AWS region you want to deploy your resources to
# }

# VPC Module
# main.tf - Root configuration for your project

provider "aws" {
  region = var.region  # AWS region defined in variables.tf
}

# VPC Module - Ensure VPC is created first
module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = var.vpc_cidr_block
  subnet_cidr_block  = var.subnet_cidr_block
  availability_zone  = var.availability_zone
  tags               = var.tags
}

# IAM Module - Role for Redshift
module "iam" {
  source        = "./modules/iam"
  iam_role_name = var.iam_role_name
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
