# modules/redshift_serverless/variables.tf


# Variable to define the Redshift database name
variable "redshift_db_name" {
  description = "The name of the Redshift database"
  type        = string
}

# Variable to define the Redshift master username
variable "redshift_master_username" {
  description = "The master username for the Redshift database"
  type        = string
}

# Variable to define the Redshift master password
variable "redshift_master_password" {
  description = "The master password for the Redshift database"
  type        = string
  sensitive   = true  # Marks the password as sensitive so it is not displayed in outputs
}

# Variable to reference the VPC ID
variable "vpc_id" {
  description = "The ID of the VPC to launch Redshift into"
  type        = string
}

# Variable to define subnet IDs for Redshift
variable "subnet_ids" {
  description = "A list of subnet IDs to launch Redshift into"
  type        = list(string)
}

# Variable to define security group IDs for Redshift
variable "security_group_ids" {
  description = "A list of security group IDs for the Redshift instance"
  type        = list(string)
}
