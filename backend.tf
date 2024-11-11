terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"    # Name of your S3 bucket
    key            = "terraform/dev.tfstate"   # Path to the state file in the bucket
    # region         = "us-west-2"                     # The AWS region where the bucket is located
    encrypt        = true                            # Enable encryption for the state file
  }
}
