
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

variable "project_name" {
  description = "The name of the project, used for tagging"
  type        = string
  default = "dwh-dev"
}

variable "allowed_ips" {
  description = "The IP addresses allowed to connect to Redshift"
  type        = list(string)
}
