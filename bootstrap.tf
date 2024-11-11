resource "aws_s3_bucket" "state_backend" {
  bucket = "stat11"    # The S3 bucket name for state and lock
  region = "eu-central-1"                  # AWS region

  versioning {
    enabled = true  # Enable versioning for state locking
  }


  lifecycle {
    prevent_destroy = true  # Prevent accidental deletion of the bucket
  }
}
