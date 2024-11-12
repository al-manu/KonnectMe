# backend.tf (optional, you can leave it empty if configuring via -backend-config)

terraform {
#   Do NOT define a backend block here if using -backend-config dynamically
#   Example of leaving it empty:
  backend "s3" {
    # bucket = "your-bucket"
    # key     = "dev/terraform.tfstate"
    # # region  = "us-west-1"
    encrypt = true                         # Enable encryption for state files
    acl     = "bucket-owner-full-control"   # Optional ACL setting for full control
  }
}
