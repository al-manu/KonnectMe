# Define the module for creating S3 buckets
module "s3_buckets" {
  source = "./modules/S3"  # Path to the S3 module
  
  # Pass the required variables to the module (from dev.tfvars, prod.tfvars, etc.)
  in_bucket_name     = var.in_bucket_name
  out_bucket_name    = var.out_bucket_name
  tmp_bucket_name    = var.tmp_bucket_name
  export_bucket_name = var.export_bucket_name
}




# Module to deploy Redshift Serverless

# main.tf (Root Module)

# Call the VPC module to create the VPC, subnets, and security group
module "vpc" {
  source = "./modules/vpc"

  cidr_block            = "10.0.0.0/16"
  public_subnet_cidr    = "10.0.0.0/22"
  private_subnet_cidr   = "10.0.4.0/22"
  public_subnet_az      = "eu-central-1a"
  private_subnet_az     = "eu-central-1b"
}

# Call the Redshift Serverless module to create Redshift resources
module "redshift_serverless" {
  source = "./modules/redshift_serverless"

  redshift_db_name         = var.redshift_db_name
  redshift_master_username = var.redshift_master_username
  redshift_master_password = var.redshift_master_password
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = [module.vpc.private_subnet_id, module.vpc.public_subnet_id]
  security_group_ids       = [module.vpc.security_group_id]
  base_capacity            = var.base_capacity
}
