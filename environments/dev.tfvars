# Terraform variables for the DEV environment
# These variables define the names of the S3 buckets used for different stages in the data pipeline.

# The input S3 bucket where raw data is ingested.
in_bucket_name = "dwh-dev-ingestion"

# The output S3 bucket where transformed data is staged.
out_bucket_name = "dwh-dev-stagingg"

# Temporary S3 bucket for refined/processed data.
tmp_bucket_name = "dwh-dev-refined"

# The S3 bucket for exporting curated data to be consumed by other systems or processes.
export_bucket_name = "dwh-dev-curated"

# # Optionally add other variables for the S3 configuration (e.g., versioning, encryption)
# enable_versioning = true  # Enable versioning for the buckets (recommended for production environments)


# dev.tfvars (Environment-specific values)

# Redshift Variables
# redshift_db_name         = "dwhtest1"
# redshift_master_username = "admin"
# redshift_master_password = "MySecurePassword1234!"
# base_capacity            = 0  # Redshift Serverlesss minimal capacity
# # VPC and Networking Variables
# cidr_block            = "10.0.0.0/16"
# public_subnet_cidr    = "10.0.0.0/22"
# private_subnet_cidr   = "10.0.4.0/22"
# public_subnet_az      = "eu-central-1a"
# private_subnet_az     = "eu-central-1b"

# dev.tfvars

# # Redshift Serverless Configuration
# redshift_serverless_namespace = "dev-namespace"  # Redshift namespace name
# redshift_serverless_db_name   = "dev-db"          # Database name in Redshift Serverless
# redshift_serverless_workgroup = "dev-workgroup"    # Workgroup name for Redshift Serverless
# redshift_serverless_port      = 5439              # Port for Redshift (default is 5439)
# redshift_serverless_username  = "devuser"          # Username for the database
# redshift_serverless_password  = "devpassword"      # Initial password for Redshift user
# # redshift_serverless_node_type = "dc2.medium"        # Node type for the Redshift Serverless workgroup (example)

# # VPC Configuration
# vpc_cidr_block = "10.0.0.0/16"  # CIDR block for VPC in DEV environment
# subnet_ids = ["subnet-abc123", "subnet-def456"]  # Subnet IDs for Redshift Serverless cluster (ensure subnets are in different AZs)

# # Secrets Manager Configuration (for storing Redshift credentials)
# redshift_secret_name = "dev-redshift-credentials"  # Name of the secret to store in Secrets Manager
# redshift_secret_arn  = "arn:aws:secretsmanager:us-west-2:123456789012:secret:dev-redshift-credentials"

# # Redshift IAM Role (IAM Role for Redshift to access other AWS services like Secrets Manager)
# redshift_iam_role_name = "dev-redshift-iam-role"  # IAM Role name for Redshift

# # CloudWatch Logging for Redshift Serverless (Optional, for monitoring)
# cloudwatch_log_group_name = "dev-redshift-logs"  # CloudWatch Logs group name for Redshift

# # Lambda Role and Lambda Function for password rotation (if applicable)
# lambda_role_arn = "arn:aws:iam::123456789012:role/lambda-execution-role"
# lambda_function_arn = "arn:aws:lambda:us-west-2:123456789012:function:redshift-password-rotation"

# # S3 Bucket for Terraform State (if using remote state)
# terraform_state_bucket = "dev-terraform-state-bucket"  # S3 bucket name for storing the Terraform state file

# # AWS Region (typically set per environment)
aws_region = "eu-central-1"  # AWS region for the DEV environment



# dev.tfvars
# cidr_block = "10.0.0.0/16"
# subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
# availability_zones = ["eu-central-1a", "eu-central-1b"]
# namespace_name = "dev-namespace"
# db_name = "devdb"
# admin_username = "admin"
# admin_password = "supersecretpassword"  # Ensure this is securely managed
# base_capacity = 0
# subnet_ids = ["subnet-xyz", "subnet-abc"]
# security_group_ids = ["sg-xyz"]

# dev.tfvars - Environment-specific variables for the development environment
# dev.tfvars

# dev.tfvars

# IAM Role Name for Redshift
iam_role_name = "redshift-role-for-project"  # Name of the IAM role for Redshift

# Tags (You can use these tags across resources for easy identification)
tags = {
  Environment = "dev"
  Project     = "redshift-migration"
}

# Redshift Specific Variables
namespace_name   = "my-redshift-namespace"
workgroup_name   = "my-redshift-workgroup"
base_capacity    = 16  # Starting capacity units for Redshift serverless
enhanced_vpc_routing = true  # Enable enhanced VPC routing
log_exports      = ["userlog", "connectionlog", "useractivitylog"]  # Logs to export
db_username      = "adminuser"  # DB Username
db_password      = "mysecretpassword"  # DB Password, ideally stored in Secrets Manager
db_host          = "redshift-cluster-name"  # Hostname of the Redshift cluster
db_port          = 5439  # Port for Redshift connection
db_name          = "mydatabase"  # Database name to create in Redshift

# VPC Configuration
vpc_cidr_block       = "10.0.0.0/16"  # CIDR block for the VPC
subnet_cidr_blocks   = ["10.0.1.0/24", "10.0.2.0/24"]  # Subnet CIDRs (Two subnets in different availability zones)
availability_zone    = "eu-central-1a"  # Availability Zone for your subnets
vpc_security_group_ids = ["sg-xxxxxxxx"]  # Security group for VPC (this is the Security Group ID that Redshift will use)

# Secrets Manager Configuration
secret_name    = "redshift-db-credentials"  # Name for the Secrets Manager secret
secret_value   = "password-to-be-rotated"  # Value stored in the secret, ideally this is handled by Lambda for rotation
secret_description = "Redshift database credentials for dev environment"  # Optional description for the secret

# Lambda (Optional - If you're rotating passwords)
lambda_function_name = "redshift-password-rotation"  # Lambda function name for rotating passwords


