variable "in_bucket_name" {
  description = "Name of the input S3 bucket"
  type        = string
}

variable "out_bucket_name" {
  description = "Name of the output S3 bucket"
  type        = string
}

variable "tmp_bucket_name" {
  description = "Name of the temporary S3 bucket"
  type        = string
}

variable "export_bucket_name" {
  description = "Name of the export S3 bucket"
  type        = string
}