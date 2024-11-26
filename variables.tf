
# AWS Region
variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-central-1"
}

# VPC CIDR block
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

# Private subnets CIDRs
variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

# Availability zones
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

# Tags for resources
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

# Project name for tagging
variable "project_name" {
  description = "The name of the project, used for tagging"
  type        = string
}

# Allowed IPs for Redshift access
variable "allowed_ips" {
  description = "The IP addresses allowed to connect to Redshift"
  type        = list(string)
}

# IAM Role name for Redshift
variable "iam_role_name" {
  description = "IAM role name for Redshift"
  type        = string
}

# Secrets Manager configuration for DB credentials
variable "secret_name" {
  description = "Name of the secret in Secrets Manager"
  type        = string
}

variable "secret_description" {
  description = "Description of the secret"
  type        = string
}

# DB username and password for Redshift
variable "db_username" {
  description = "Redshift DB username"
  type        = string
}

variable "db_password" {
  description = "Redshift DB password"
  type        = string
}

# Redshift workgroup and capacity
variable "workgroup_name" {
  description = "Redshift workgroup name"
  type        = string
}

variable "base_capacity" {
  description = "Base capacity for Redshift workgroup"
  type        = number
}

# Enhanced VPC Routing for Redshift
variable "enhanced_vpc_routing" {
  description = "Whether to enable enhanced VPC routing"
  type        = bool
}

# List of log exports for Redshift
variable "log_exports" {
  description = "List of log types to export from Redshift"
  type        = list(string)
}

# Redshift namespace name
variable "namespace_name" {
  description = "Redshift namespace name"
  type        = string
}
