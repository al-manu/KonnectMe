# Define variables for all configurable parameters

# AWS Region
variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

# Private Subnets Configuration
variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

# Availability Zones Configuration
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

# General Tags for Resources
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

# Project Name for Tagging
variable "project_name" {
  description = "The name of the project, used for tagging"
  type        = string
}

# Allowed IPs for Redshift Access
variable "allowed_ips" {
  description = "The IP addresses allowed to connect to Redshift"
  type        = list(string)
}

# IAM Role Configuration for Redshift
variable "iam_role_name" {
  description = "IAM role name for Redshift"
  type        = string
}

# Secrets Manager Configuration
variable "secret_name" {
  description = "Name of the secret in Secrets Manager"
  type        = string
}

variable "secret_description" {
  description = "Description of the secret"
  type        = string
}

# Redshift DB Credentials
variable "db_username" {
  description = "Redshift DB username"
  type        = string
}

variable "db_password" {
  description = "Redshift DB password"
  type        = string
}

# Redshift Workgroup and Capacity
variable "workgroup_name" {
  description = "Redshift workgroup name"
  type        = string
}

variable "base_capacity" {
  description = "Redshift workgroup base capacity"
  type        = number
}

# Enhanced VPC Routing Setting
variable "enhanced_vpc_routing" {
  description = "Whether to enable enhanced VPC routing"
  type        = bool
}

# Redshift Logs Configuration
variable "log_exports" {
  description = "List of log types to export from Redshift"
  type        = list(string)
}

# Redshift Namespace Name
variable "namespace_name" {
  description = "Redshift namespace name"
  type        = string
}

# Namespace and Workgroup for Redshift Serverless

variable "admin_username" {
  description = "Admin username for the Redshift Serverless namespace"
  type        = string
}

# variable "admin_password" {
#   description = "Admin password for the Redshift Serverless namespace"
#   type        = string
# }

# variable "vpc_security_group_id" {
#   description = "The security group ID for the Redshift Serverless workgroup"
#   type        = string
# }

# variable "secret_arn" {
#   description = "The ARN of the Secrets Manager secret containing the admin password"
#   type        = string
# }