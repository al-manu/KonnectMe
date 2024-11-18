# variables.tf (Root Level)

# S3 bucket names for different purposes
variable "in_bucket_name" {
  description = "Name for the input S3 bucket"
  type        = string
}

variable "out_bucket_name" {
  description = "Name for the output S3 bucket"
  type        = string
}

variable "tmp_bucket_name" {
  description = "Name for the temporary S3 bucket"
  type        = string
}

variable "export_bucket_name" {
  description = "Name for the export S3 bucket"
  type        = string
}



variable "vpc_id" {
  description = "The VPC ID where Redshift will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for Redshift deployment"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for Redshift"
  type        = list(string)
}

variable "redshift_db_name" {
  description = "The name of the Redshift database"
  type        = string
}

variable "redshift_master_username" {
  description = "Master username for the Redshift database"
  type        = string
}

variable "redshift_master_password" {
  description = "Master password for the Redshift database"
  type        = string
}
