resource "aws_s3_bucket" "state_backend" {
  bucket = "your-state-bucket-name"    # The S3 bucket name for state and lock
  # region = "us-east-1"                  # AWS region

  versioning {
    enabled = true  # Enable versioning for state locking
  }


  lifecycle {
    prevent_destroy = true  # Prevent accidental deletion of the bucket
  }
}
