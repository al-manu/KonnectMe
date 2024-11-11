terraform {
  backend "s3" {
    bucket         = "stat11"   # The S3 bucket for storing state
    key            = "terraform/states.tfstate"  # Path inside the S3 bucket for the state file
    # region         = "eu-central-1"                 # AWS Region where your bucket is located
    encrypt        = true                        # Enable encryption for the state file
    # versioning     = true                        # Enable versioning to track changes in state (acts like a lock)
    # lock           = true                        # Use S3's versioning mechanism as a lock
  }
}
