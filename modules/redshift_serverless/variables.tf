# # modules/redshift_serverless/variables.tf

# # The name of the Redshift database
# variable "redshift_db_name" {
#   description = "The name of the Redshift database"
#   type        = string
# }

# # Redshift master username
# variable "redshift_master_username" {
#   description = "Master username for the Redshift database"
#   type        = string
# }

# # Redshift master password
# variable "redshift_master_password" {
#   description = "Master password for the Redshift database"
#   type        = string
#   sensitive   = true
# }

# # VPC and subnet IDs
# variable "vpc_id" {
#   description = "The ID of the VPC where Redshift will be deployed"
#   type        = string
# }

# variable "subnet_ids" {
#   description = "List of subnet IDs where Redshift will be deployed"
#   type        = list(string)
# }

# variable "security_group_ids" {
#   description = "List of security group IDs associated with Redshift"
#   type        = list(string)
# }

# # Redshift serverless base capacity
# variable "base_capacity" {
#   description = "Base capacity for Redshift Serverless workgroup"
#   type        = number
#   default     = 0
# }


variable "subnet_ids" {
  description = "The subnet IDs for Redshift"
  type        = list(string)
}

variable "security_group_ids" {
  description = "The security group IDs for Redshift"
  type        = list(string)
}

variable "admin_password" {
  description = "The admin password for Redshift"
  type        = string
}
