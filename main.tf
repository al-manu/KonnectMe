# Define the module for creating S3 buckets
module "s3_buckets" {
  source = "./modules/S3"  # Path to the S3 module
  
  # Pass the required variables to the module (from dev.tfvars, prod.tfvars, etc.)
  in_bucket_name     = var.in_bucket_name
  out_bucket_name    = var.out_bucket_name
  tmp_bucket_name    = var.tmp_bucket_name
  export_bucket_name = var.export_bucket_name
}

module "redshift_serverless" {
  source = "./modules/redshift_serverless"

  redshift_db_name         = "myredshiftdb"
  redshift_master_username = "admin"
  redshift_master_password = "MySecurePassword123!"
  vpc_id                   = aws_vpc.redshift_vpc.id  # Reference the VPC ID created by Terraform
  subnet_ids               = [
    aws_subnet.redshift_subnet_private.id,
    aws_subnet.redshift_subnet_public.id
  ]  # Reference the subnet IDs created by Terraform
  security_group_ids       = [aws_security_group.redshift_sg.id]  # Reference the SG ID created by Terraform
}
