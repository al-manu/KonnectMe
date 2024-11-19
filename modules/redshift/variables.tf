# modules/redshift/variables.tf
variable "namespace_name" {
  description = "The name of the Redshift namespace."
  type        = string
}

variable "db_name" {
  description = "The name of the Redshift database."
  type        = string
}

variable "admin_username" {
  description = "The username for the Redshift admin."
  type        = string
}

variable "admin_password" {
  description = "The password for the Redshift admin."
  type        = string
}

variable "base_capacity" {
  description = "The base capacity of the Redshift workgroup."
  type        = number
}

variable "subnet_ids" {
  description = "The list of subnet IDs for the Redshift workgroup."
  type        = list(string)
}

variable "security_group_ids" {
  description = "The list of security group IDs for the Redshift workgroup."
  type        = list(string)
}
