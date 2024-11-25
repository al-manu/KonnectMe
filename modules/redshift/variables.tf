# Namespace Variables
variable "namespace_name" {
  description = "The name of the Redshift namespace"
  type        = string
}

variable "admin_username" {
  description = "Admin username for Redshift"
  type        = string
}

variable "admin_password" {
  description = "Admin password for Redshift"
  type        = string
  sensitive   = true
}

variable "log_exports" {
  description = "Logs to export (e.g., userlog, connectionlog, useractivitylog)"
  type        = list(string)
  default     = ["userlog", "connectionlog", "useractivitylog"]
}

# Workgroup Variables
variable "workgroup_name" {
  description = "The name of the Redshift workgroup"
  type        = string
}

variable "base_capacity" {
  description = "Compute capacity in Redshift Processing Units (RPUs)"
  type        = number
  default     = 8
}

variable "subnet_ids" {
  description = "Subnets for the Redshift workgroup"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups for the Redshift workgroup"
  type        = list(string)
}

variable "iam_roles" {
  description = "IAM roles for Redshift to access other AWS services (e.g., S3)"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {}
}
