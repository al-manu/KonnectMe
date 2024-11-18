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

variable "base_capacity" {
  description = "Base capacity for Redshift Serverless workgroup"
  type        = number
  default     = 0  # Default to 0 for serverless
}
