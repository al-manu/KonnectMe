# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones for subnets"
  type        = list(string)
}

# Security Group Configuration
variable "allowed_ips" {
  description = "List of CIDR blocks allowed to access Redshift"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Replace with restricted IPs in production
}

# Tags and Metadata
variable "project_name" {
  description = "Project name for tagging"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
