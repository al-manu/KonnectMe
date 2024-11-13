terraform {
  backend "s3" {
    encrypt = true                         # Enable encryption for state files
    acl     = "bucket-owner-full-control"   # Optional ACL setting for full control
  }
}
