# variables.tf - Define all the variables required for the Terraform configuration

# AWS Region
variable "region" {
  description = "The AWS region where the resources will be deployed"
  default     = "eu-central-1"
}

# Redshift Serverless Configuration
variable "namespace_name" {
  description = "The name of the Redshift Serverless namespace"
  type        = string
}

variable "workgroup_name" {
  description = "The name of the Redshift Serverless workgroup"
  type        = string
}

variable "base_capacity" {
  description = "Base capacity for the Redshift workgroup"
  type        = number
}

variable "enhanced_vpc_routing" {
  description = "Enable enhanced VPC routing for Redshift"
  type        = bool
}

variable "log_exports" {
  description = "List of log exports for Redshift"
  type        = list(string)
  default     = []
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
}

variable "db_host" {
  description = "Redshift endpoint"
  type        = string
}

variable "db_port" {
  description = "Redshift port"
  type        = number
  default     = 5439
}

variable "db_name" {
  description = "Redshift database name"
  type        = string
}

# IAM Configuration
variable "iam_role_name" {
  description = "IAM role name to be used for Redshift"
  type        = string
}

# VPC Configuration
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
}

# Secrets Manager Configuration
variable "secret_name" {
  description = "Name of the secret in Secrets Manager"
  type        = string
}

variable "secret_value" {
  description = "The value of the secret (password)"
  type        = string
}

variable "secret_description" {
  description = "Description of the secret"
  type        = string
}

# Tags for all resources
variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
  default     = {
    "Environment" = "dev"
    "Project"     = "KonnectMe"
  }
}
