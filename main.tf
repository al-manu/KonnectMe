# # --------------------------------------------------------------------------------------
# # Create S3 buckets 
# # --------------------------------------------------------------------------------------

# # Create the input S3 bucket
# resource "aws_s3_bucket" "in_bucket" {
#   # count  = length(data.aws_s3_bucket.existing_bucket) == 0 ? 1 : 0
#   bucket = var.in_bucket_name  # Name of the input bucket.
# }

# # Check if the bucket already exists
# data "aws_s3_bucket" "existing_bucket" {
#   bucket = "test-in-oct2401"  # The bucket name you want to check
# }

# # Create the output S3 bucket
# resource "aws_s3_bucket" "out_bucket" {
#   bucket = var.out_bucket_name  # Name of the output bucket
# }

# # Create the temporary S3 bucket
# resource "aws_s3_bucket" "tmp_bucket" {
#   bucket = var.tmp_bucket_name  # Name of the temporary bucket
# }

# # Create the export S3 bucket
# resource "aws_s3_bucket" "export_bucket" {
#   bucket = var.export_bucket_name  # Name of the export bucket
# }



















# # Define the common "directory" prefix
# variable "common_prefix" {
#   default = "project-directory/"
# }

# Create the input S3 bucket
resource "aws_s3_bucket" "in_bucket" {
  bucket = var.in_bucket_name
}


# Create the output S3 bucket
resource "aws_s3_bucket" "out_bucket" {
  bucket = var.out_bucket_name
}

# Create the temporary S3 bucket
resource "aws_s3_bucket" "tmp_bucket" {
  bucket = var.tmp_bucket_name
}

# Create the export S3 bucket
resource "aws_s3_bucket" "export_bucket" {
  bucket = var.export_bucket_name
}

# You can simulate the "directory structure" by uploading an object with a prefix.
resource "aws_s3_bucket_object" "example_input_object" {
  bucket = aws_s3_bucket.in_bucket.bucket
  key    = "${var.common_prefix}input-object.txt"  # Object with a "directory" prefix
  content = "This is an input object"
}

resource "aws_s3_bucket_object" "example_output_object" {
  bucket = aws_s3_bucket.out_bucket.bucket
  key    = "${var.common_prefix}output-object.txt"  # Object with a "directory" prefix
  content = "This is an output object"
}

resource "aws_s3_bucket_object" "example_tmp_object" {
  bucket = aws_s3_bucket.tmp_bucket.bucket
  key    = "${var.common_prefix}tmp-object.txt"  # Object with a "directory" prefix
  content = "This is a temporary object"
}

resource "aws_s3_bucket_object" "example_export_object" {
  bucket = aws_s3_bucket.export_bucket.bucket
  key    = "${var.common_prefix}export-object.txt"  # Object with a "directory" prefix
  content = "This is an export object"
}
