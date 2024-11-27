# --------------------------------------------------------
# Variables: Configurable Parameters for Redshift Module
# --------------------------------------------------------

# ------------------------
# AWS Configuration
# ------------------------

# AWS Region
# Specify the AWS region where resources will be deployed. Default is 'eu-central-1'.
variable "region" {
  description = "AWS region where resources will be deployed (e.g., eu-central-1)"
  type        = string
  default     = "eu-central-1"  # Default region set to Europe (Central)
}

# # ------------------------
# # VPC Configuration
# # ------------------------

# # CIDR Block for the VPC
# # The CIDR block defines the IP address range for the VPC.
# variable "vpc_cidr" {
#   description = "CIDR block for the VPC (e.g., 10.0.0.0/16)"
#   type        = string
# }

# # CIDR Blocks for Private Subnets
# # A list of CIDR blocks for private subnets within the VPC.
# variable "private_subnet_cidrs" {
#   description = "List of CIDR blocks for private subnets (e.g., [10.0.1.0/24, 10.0.2.0/24])"
#   type        = list(string)
# }

# # Availability Zones for Subnets
# # A list of availability zones to place the private subnets.
# variable "availability_zones" {
#   description = "List of availability zones for the private subnets"
#   type        = list(string)
# }

# # ------------------------
# # Tagging Configuration
# # ------------------------

# # General Tags for Resources
# # A map of tags to apply to all resources for easier identification and cost allocation.
# variable "tags" {
#   description = "Tags to apply to all resources (e.g., {Environment = 'Dev', Team = 'Data'})"
#   type        = map(string)
# }

# # Project Name for Tagging
# # The project name for tagging resources, making them identifiable as part of the same project.
# variable "project_name" {
#   description = "Project name for tagging resources (e.g., redshift-project)"
#   type        = string
# }

# # ------------------------
# # Security and Access Configuration
# # ------------------------

# # Allowed IPs for Redshift Access
# # List of IP addresses or CIDR blocks that are allowed to connect to Redshift (e.g., office IPs).
# variable "allowed_ips" {
#   description = "IP addresses or ranges allowed to connect to Redshift (e.g., [203.0.113.0/24])"
#   type        = list(string)
# }

# # IAM Role Name for Redshift
# # Name of the IAM role that allows Redshift to access AWS services like Secrets Manager, etc.
# variable "iam_role_name" {
#   description = "Name of the IAM role assigned to Redshift for accessing AWS services"
#   type        = string
# }

# # ------------------------
# # Secrets Manager Configuration
# # ------------------------

# # Secret Name for Redshift Credentials
# # Name of the secret in AWS Secrets Manager where Redshift database credentials are stored.
# variable "secret_name" {
#   description = "Name of the secret in Secrets Manager for Redshift credentials"
#   type        = string
# }

# # Secret Description for Documentation
# # Description for the secret to help with identification and documentation in Secrets Manager.
# variable "secret_description" {
#   description = "Description of the secret stored in Secrets Manager"
#   type        = string
# }

# # ------------------------
# # Redshift Configuration
# # ------------------------

# # Redshift DB Credentials
# # Admin username for Redshift database.
# variable "db_username" {
#   description = "Admin username for Redshift database"
#   type        = string
# }

# # Redshift DB Password
# # Admin password for Redshift database.
# variable "db_password" {
#   description = "Admin password for Redshift database"
#   type        = string
# }

# # Redshift Workgroup Settings
# # Name of the Redshift Serverless workgroup.
# variable "workgroup_name" {
#   description = "Name of the Redshift Serverless workgroup"
#   type        = string
# }

# # Base Capacity for Redshift Workgroup
# # The compute capacity (in Redshift Processing Units - RPU) allocated for the Redshift workgroup.
# variable "base_capacity" {
#   description = "Compute capacity (in RPU) for the Redshift workgroup"
#   type        = number
# }

# # Enhanced VPC Routing
# # Whether to enable Enhanced VPC Routing for Redshift Serverless, improving data transfer performance.
# variable "enhanced_vpc_routing" {
#   description = "Enable enhanced VPC routing for Redshift Serverless (true/false)"
#   type        = bool
# }

# # Redshift Log Exports
# # A list of logs to export from Redshift (e.g., userlog, connectionlog) for monitoring and auditing.
# variable "log_exports" {
#   description = "List of log types to export from Redshift (e.g., [userlog, connectionlog])"
#   type        = list(string)
# }

# # Redshift Namespace
# # Name of the Redshift Serverless namespace, a container for Redshift workloads.
# variable "namespace_name" {
#   description = "Name of the Redshift Serverless namespace"
#   type        = string
# }

# # Use KMS Encryption for Redshift
# # Whether to use AWS Key Management Service (KMS) encryption for Redshift resources, such as database credentials.
# variable "use_kms_encryption" {
#   description = "Whether to use KMS encryption for Redshift"
#   type        = bool
#   default     = true  # Set it to 'true' if you want KMS encryption by default
# }
