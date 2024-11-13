# Outputs for the S3 buckets
output "in_bucket_id" {
  description = "The ID of the input S3 bucket"
  value       = aws_s3_bucket.in.id
}

output "out_bucket_id" {
  description = "The ID of the output S3 bucket"
  value       = aws_s3_bucket.out.id
}

output "tmp_bucket_id" {
  description = "The ID of the temporary S3 bucket"
  value       = aws_s3_bucket.tmp.id
}

output "export_bucket_id" {
  description = "The ID of the export S3 bucket"
  value       = aws_s3_bucket.export.id
}