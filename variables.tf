# ----------------------------------------
# AWS Region and Network Configuration
# ----------------------------------------

# AWS Region where resources will be deployed
variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-central-1"  # Default region set to Europe (Central)
}

# CIDR block for the Virtual Private Cloud (VPC)
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

# List of CIDR blocks for private subnets within the VPC
variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

# Availability zones for the subnets in the region
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

# ----------------------------------------
# Tagging and Project Details
# ----------------------------------------

# Tags to apply to all resources for identification and cost management
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

# Project name used for tagging resources and tracking costs
variable "project_name" {
  description = "The name of the project, used for tagging"
  type        = string
}

# ----------------------------------------
# Networking and Security Configuration
# ----------------------------------------

# List of allowed IP addresses to connect to Redshift
variable "allowed_ips" {
  description = "The IP addresses allowed to connect to Redshift"
  type        = list(string)
}

# IAM role name for Redshift to access other AWS services
variable "iam_role_name" {
  description = "IAM role name for Redshift"
  type        = string
}

# ----------------------------------------
# Secrets Manager and Database Configuration
# ----------------------------------------

# Name of the secret in AWS Secrets Manager for Redshift credentials
variable "secret_name" {
  description = "Name of the secret in Secrets Manager"
  type        = string
}

# Description for the secret stored in Secrets Manager
variable "secret_description" {
  description = "Description of the secret"
  type        = string
}

# Redshift database admin username (stored in Secrets Manager)
variable "db_username" {
  description = "Redshift DB username"
  type        = string
}

# Redshift database admin password (stored in Secrets Manager)
variable "db_password" {
  description = "Redshift DB password"
  type        = string
}

# ----------------------------------------
# Redshift Workgroup and Capacity Configuration
# ----------------------------------------

# Name of the Redshift workgroup (compute environment)
variable "workgroup_name" {
  description = "Redshift workgroup name"
  type        = string
}

# Base capacity (RPU) for Redshift workgroup
variable "base_capacity" {
  description = "Base capacity for Redshift workgroup"
  type        = number
}

# ----------------------------------------
# Redshift Features Configuration
# ----------------------------------------

# Enable enhanced VPC routing for Redshift (true/false)
variable "enhanced_vpc_routing" {
  description = "Whether to enable enhanced VPC routing"
  type        = bool
}

# List of log types to export from Redshift for monitoring
variable "log_exports" {
  description = "List of log types to export from Redshift"
  type        = list(string)
}

# Redshift namespace name for organizing resources
variable "namespace_name" {
  description = "Redshift namespace name"
  type        = string
}

# ----------------------------------------
# Encryption Configuration
# ----------------------------------------

# Whether to use KMS encryption for Redshift (default is true)
variable "use_kms_encryption" {
  description = "Whether to use KMS encryption for Redshift"
  type        = bool
  default     = true  # Set to 'true' for KMS encryption
}
