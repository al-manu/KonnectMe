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



# variables.tf (Root Module)

# Redshift Database Name
variable "redshift_db_name" {
  description = "The name of the Redshift database"
  type        = string
}

# Redshift Master Username
variable "redshift_master_username" {
  description = "Master username for the Redshift database"
  type        = string
}

# Redshift Master Password
variable "redshift_master_password" {
  description = "Master password for the Redshift database"
  type        = string
}

# Base Capacity for Redshift Serverless Workgroup
variable "base_capacity" {
  description = "Base capacity for Redshift Serverless"
  type        = number
  default     = 0
}
