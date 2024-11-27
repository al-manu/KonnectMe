# # ----------------------------------------
# # Root Module Configuration
# # ----------------------------------------

# # AWS Provider Configuration
# # Configures the AWS provider to use the region defined in the variables.
# provider "aws" {
#   region = var.region
# }

# # ----------------------------------------
# # Redshift Module - Serverless Cluster Configuration
# # ----------------------------------------

# # This module provisions a Redshift Serverless cluster with networking, IAM, and security configurations.
# module "redshift" {
#   source = "./modules/redshift"

#   # ------------------------
#   # General Configuration
#   # ------------------------

#   # AWS Region where the Redshift cluster will be deployed.
#   region               = var.region

#   # The name of the Redshift Serverless namespace for grouping Redshift resources.
#   namespace_name       = var.namespace_name

#   # The name of the Redshift workgroup (compute environment).
#   workgroup_name       = var.workgroup_name

#   # The compute capacity in Redshift Processing Units (RPU) to allocate for the workgroup.
#   base_capacity        = var.base_capacity

#   # Enable enhanced VPC routing for improved network performance.
#   enhanced_vpc_routing = var.enhanced_vpc_routing

#   # Types of logs to be exported from Redshift for monitoring (e.g., userlog, connectionlog).
#   log_exports          = var.log_exports

#   # ------------------------
#   # Networking and Security Configuration
#   # ------------------------

#   # CIDR block for the Virtual Private Cloud (VPC).
#   vpc_cidr             = var.vpc_cidr

#   # List of CIDR blocks for private subnets within the VPC.
#   private_subnet_cidrs = var.private_subnet_cidrs

#   # List of availability zones for subnet placement.
#   availability_zones   = var.availability_zones

#   # List of allowed IPs or IP ranges that can access the Redshift instance.
#   allowed_ips          = var.allowed_ips

#   # ------------------------
#   # IAM Integration
#   # ------------------------

#   # The name of the IAM role that provides necessary permissions for Redshift to access other AWS services.
#   iam_role_name        = var.iam_role_name

#   # ------------------------
#   # Secrets Manager Configuration
#   # ------------------------

#   # Name of the secret in AWS Secrets Manager that contains the Redshift credentials.
#   secret_name          = var.secret_name

#   # Description of the secret stored in Secrets Manager.
#   secret_description   = var.secret_description

#   # Admin username for the Redshift database (stored in Secrets Manager).
#   db_username          = var.db_username

#   # Admin password for the Redshift database (stored in Secrets Manager).
#   db_password          = var.db_password

#   # ------------------------
#   # Tags and Project Details
#   # ------------------------

#   # Tags to apply to all resources for easier identification and management.
#   tags                 = var.tags

#   # Project name for tagging resources and tracking costs.
#   project_name         = var.project_name
# }
