# variables.tf (Root)
variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "subnet_cidr_blocks" {
  description = "List of CIDR blocks for the subnets."
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones for the subnets."
  type        = list(string)
}

variable "namespace_name" {
  description = "The Redshift namespace name."
  type        = string
}

variable "db_name" {
  description = "The Redshift database name."
  type        = string
}

variable "admin_username" {
  description = "The username for the Redshift database."
  type        = string
}

variable "base_capacity" {
  description = "The base capacity for Redshift serverless workgroup."
  type        = number
}

variable "secret_value" {
  description = "Admin password for Redshift database."
  type        = string
}
