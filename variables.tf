# variables.tf (Root Level)

# S3 bucket names for different purposes
variable "in_bucket_name" {
  description = "Name for the input S3 bucket"
  type        = string
}

variable "out_bucket_name" {
  description = "Name for the output S3 bucket"
  type        = string
}

variable "tmp_bucket_name" {
  description = "Name for the temporary S3 bucket"
  type        = string
}

variable "export_bucket_name" {
  description = "Name for the export S3 bucket"
  type        = string
}
