variable "in_bucket_name" {
  description = "Name of the input S3 bucket"
  type        = string
  default     = "test-in-oct2401"  # Change this as needed for your environment
}

variable "out_bucket_name" {
  description = "Name of the output S3 bucket"
  type        = string
  default     = "test-out-oct2401"  # Change this as needed for your environment
}

variable "tmp_bucket_name" {
  description = "Name of the temporary S3 bucket"
  type        = string
  default     = "test-tmp-oct2401"  # Change this as needed for your environment
}

variable "export_bucket_name" {
  description = "Name of the export S3 bucket"
  type        = string
  default     = "test-export-oct2401"  # Change this as needed for your environment
}