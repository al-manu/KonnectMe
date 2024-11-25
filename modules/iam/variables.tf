# Input Variables
variable "project_name" {
  description = "Project name for resource tagging"
  type        = string
}

variable "s3_bucket_arns" {
  description = "List of ARNs for S3 buckets Redshift can access"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to all IAM resources"
  type        = map(string)
  default     = {}
}

variable "iam_role_name" {
  description = "IAM role name to be used for Redshift"
  type        = string
}