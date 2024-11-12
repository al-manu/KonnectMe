variable "environment" {
  description = "The environment name (dev, staging, prod)"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

provider "aws" {
  region = var.region
}

# Check if the bucket already exists
data "aws_s3_bucket" "existing" {
  bucket = "proj-${var.environment}-terraform-state"
  # The data source will fail if the bucket does not exist
}

# Create the S3 bucket if it does not already exist
resource "aws_s3_bucket" "terraform_state" {
  count  = data.aws_s3_bucket.existing.id == "" ? 1 : 0
  bucket = "proj-${var.environment}-terraform-state"
  acl    = "private"

  tags = {
    Name        = "Terraform State Bucket - ${var.environment}"
    Environment = var.environment
  }
}

# Create versioning configuration for the bucket
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state[0].bucket

  versioning_configuration {
    status = "Enabled"
  }
}

# # Create encryption configuration for the bucket
# resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
#   bucket = aws_s3_bucket.terraform_state[0].bucket

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

output "bucket_name" {
  value = aws_s3_bucket.terraform_state[0].bucket
}
