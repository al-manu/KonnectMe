# resource "aws_s3_bucket" "terraform_state" {
#   bucket = "kstate-bucket"   # Replace with your S3 bucket name
#   acl    = "private"
#   region = "us-west-2"

#   versioning {
#     enabled = true
#   }

#   object_lock_configuration {
#     object_lock_enabled = "Enabled"
#     rule {
#       default_retention {
#         mode = "COMPLIANCE"  # You can change to "GOVERNANCE" if you need less strict retention
#         days = 30            # Specify retention period, e.g., 30 days
#       }
#     }
#   }
# }
