terraform {
  backend "s3" {
    bucket         = "Kstate-bucket"    # Replace with your S3 bucket name
    key            = "dev/terraform.tfstate"       # Path within the S3 bucket (can be customized for each environment)
    # region         = "us-west-2"                   # Region for the S3 bucket
    encrypt        = true
    acl            = "bucket-owner-full-control"
  }
}
