# ----------------------------------------
# AWS Region Configuration
# ----------------------------------------
region = "eu-central-1"  # AWS region for the DEV environment

# ----------------------------------------
# VPC and Networking Configuration
# ----------------------------------------
vpc_cidr            = "10.0.0.0/16"
private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
availability_zones  = ["eu-central-1a", "eu-central-1b"]

# ----------------------------------------
# Tags and Project Information
# ----------------------------------------
tags = {
  "Environment" = "dev"
  "Project"     = "redshift-project"
}
project_name = "redshift-project"

# ----------------------------------------
# Security and Access Configuration
# ----------------------------------------
allowed_ips        = ["192.168.1.0/24", "10.0.0.0/16"]
iam_role_name      = "redshift-iam-role"
secret_name        = "redshift-db-credentials-November"
secret_description = "Redshift database credentials"

# ----------------------------------------
# Redshift Database Configuration
# ----------------------------------------
db_username        = "admin"
db_password        = "SuperSecurePassword123"
workgroup_name     = "redshift-workgroup"
base_capacity      = 8
enhanced_vpc_routing = true
log_exports        = ["user", "connection_log"]
namespace_name     = "redshift-namespace"
