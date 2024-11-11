terraform {
  backend "s3" {
    bucket         = "your-state-bucket-name"   # The S3 bucket for storing state
    key            = "terraform/state.tfstate"  # Path inside the S3 bucket for the state file
    # region         = "us-east-1"                 # AWS Region where your bucket is located
    encrypt        = true                        # Enable encryption for the state file
    versioning     = true                        # Enable versioning to track changes in state (acts like a lock)
    lock           = true                        # Use S3's versioning mechanism as a lock
  }
}
