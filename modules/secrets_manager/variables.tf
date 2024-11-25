# Input Variables
variable "project_name" {
  description = "Project name for tagging and resource naming"
  type        = string
}

variable "db_username" {
  description = "Database username for Redshift"
  type        = string
}

variable "db_password" {
  description = "Database password for Redshift"
  type        = string
}

variable "db_host" {
  description = "Redshift database endpoint"
  type        = string
}

variable "db_port" {
  description = "Port for Redshift database"
  type        = number
}

variable "db_name" {
  description = "Redshift database name"
  type        = string
}

variable "enable_rotation" {
  description = "Enable automatic password rotation"
  type        = bool
  default     = false
}

variable "rotation_interval_days" {
  description = "Rotation interval in days"
  type        = number
  default     = 30
}

variable "lambda_rotation_zip" {
  description = "Path to the Lambda function zip for rotation"
  type        = string
}

variable "lambda_execution_role_arn" {
  description = "IAM role ARN for Lambda execution"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
