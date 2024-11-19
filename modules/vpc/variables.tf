# # modules/vpc/variables.tf

# variable "cidr_block" {
#   description = "CIDR block for the VPC"
#   type        = string
# }

# variable "public_subnet_cidr" {
#   description = "CIDR block for the public subnet"
#   type        = string
# }

# variable "private_subnet_cidr" {
#   description = "CIDR block for the private subnet"
#   type        = string
# }

# variable "public_subnet_az" {
#   description = "Availability zone for the public subnet"
#   type        = string
# }

# variable "private_subnet_az" {
#   description = "Availability zone for the private subnet"
#   type        = string
# }

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my-vpc"
}

variable "subnet_cidr_blocks" {
  description = "List of CIDR blocks for subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones for subnets"
  type        = list(string)
}

variable "map_public_ip_on_launch" {
  description = "Whether to assign a public IP to instances launched in the subnet"
  type        = bool
  default     = true
}

variable "security_group_name" {
  description = "Security group name for Redshift"
  type        = string
  default     = "redshift-sg"
}

variable "ingress_cidr_blocks" {
  description = "List of CIDR blocks allowed to access Redshift (5439)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "egress_cidr_blocks" {
  description = "List of CIDR blocks allowed for egress traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
