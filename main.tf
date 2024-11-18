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

module "redshift_serverless" {
  source = "./modules/redshift_serverless"  # Path to the redshift_serverless module

  redshift_db_name         = "myredshiftdb"
  redshift_master_username = "admin"
  redshift_master_password = "MySecurePassword123!"
  vpc_id                   = aws_vpc.redshift_vpc.id  # VPC ID that is defined in the root module
  subnet_ids               = [
    aws_subnet.redshift_subnet_private.id,
    aws_subnet.redshift_subnet_public.id
  ]  # Subnet IDs defined in the root module
  security_group_ids       = [aws_security_group.redshift_sg.id]  # Security group IDs defined in the root module
  base_capacity            = 0  # Set for serverless
}

# Example of creating the VPC and subnets in the root module

resource "aws_vpc" "redshift_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "redshift_subnet_private" {
  vpc_id                  = aws_vpc.redshift_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
}

resource "aws_subnet" "redshift_subnet_public" {
  vpc_id                  = aws_vpc.redshift_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_security_group" "redshift_sg" {
  name        = "redshift-sg"
  description = "Security group for Redshift"
  vpc_id      = aws_vpc.redshift_vpc.id
}

resource "aws_security_group_rule" "redshift_ingress" {
  security_group_id = aws_security_group.redshift_sg.id
  type              = "ingress"
  from_port         = 5439  # Redshift default port
  to_port           = 5439
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
