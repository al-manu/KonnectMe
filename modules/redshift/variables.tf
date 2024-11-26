# --------------------------------------------------------
# Variables: Configurable Parameters for Redshift Module
# --------------------------------------------------------

# ------------------------
# AWS Configuration
# ------------------------

# AWS Region
variable "region" {
  description = "AWS region where resources will be deployed (e.g., eu-central-1)"
  type        = string
  default     = "eu-central-1" # Default region set to Europe (Central)
}

# ------------------------
# VPC Configuration
# ------------------------

# CIDR Block for the VPC
variable "vpc_cidr" {
  description = "CIDR block for the VPC (e.g., 10.0.0.0/16)"
  type        = string
}

# CIDR Blocks for Private Subnets
variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets (e.g., [10.0.1.0/24, 10.0.2.0/24])"
  type        = list(string)
}

# Availability Zones for Subnets
variable "availability_zones" {
  description = "List of availability zones for the private subnets"
  type        = list(string)
}

# ------------------------
# Tagging Configuration
# ------------------------

# General Tags for Resources
variable "tags" {
  description = "Tags to apply to all resources (e.g., {Environment = 'Dev', Team = 'Data'})"
  type        = map(string)
}

# Project Name for Tagging
variable "project_name" {
  description = "Project name for tagging resources (e.g., redshift-project)"
  type        = string
}

# ------------------------
# Security and Access
# ------------------------

# Allowed IPs for Redshift Access
variable "allowed_ips" {
  description = "IP addresses or ranges allowed to connect to Redshift (e.g., [203.0.113.0/24])"
  type        = list(string)
}

# IAM Role Name for Redshift
variable "iam_role_name" {
  description = "Name of the IAM role assigned to Redshift for accessing AWS services"
  type        = string
}

# ------------------------
# Secrets Manager Configuration
# ------------------------

# Secret Name for Redshift Credentials
variable "secret_name" {
  description = "Name of the secret in Secrets Manager for Redshift credentials"
  type        = string
}

# Secret Description for Documentation
variable "secret_description" {
  description = "Description of the secret stored in Secrets Manager"
  type        = string
}

# ------------------------
# Redshift Configuration
# ------------------------

# Redshift DB Credentials
variable "db_username" {
  description = "Admin username for Redshift database"
  type        = string
}

variable "db_password" {
  description = "Admin password for Redshift database"
  type        = string
}

# Redshift Workgroup Settings
variable "workgroup_name" {
  description = "Name of the Redshift Serverless workgroup"
  type        = string
}

variable "base_capacity" {
  description = "Compute capacity (in RPU) for the Redshift workgroup"
  type        = number
}

# Enhanced VPC Routing
variable "enhanced_vpc_routing" {
  description = "Enable enhanced VPC routing for Redshift Serverless (true/false)"
  type        = bool
}

# Redshift Log Exports
variable "log_exports" {
  description = "List of log types to export from Redshift (e.g., [userlog, connectionlog])"
  type        = list(string)
}

# Redshift Namespace
variable "namespace_name" {
  description = "Name of the Redshift Serverless namespace"
  type        = string
}

# ------------------------
# Deprecated or Optional Variables
# ------------------------

# Namespace Admin Credentials (Optional - Using Secrets Manager)
# variable "admin_username" {
#   description = "Admin username for the Redshift namespace (if not using Secrets Manager)"
#   type        = string
# }
#
# variable "admin_password" {
#   description = "Admin password for the Redshift namespace (if not using Secrets Manager)"
#   type        = string
# }

# Security Group ID (Deprecated - Now Dynamically Created)
# variable "vpc_security_group_id" {
#   description = "Security group ID for the Redshift workgroup"
#   type        = string
# }

# Secrets Manager Secret ARN (Optional - Dynamically Referenced)
# variable "secret_arn" {
#   description = "ARN of the Secrets Manager secret for admin credentials"
#   type        = string
# }
