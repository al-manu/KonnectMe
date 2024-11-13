output "in_bucket_arn" {
  value = aws_s3_bucket.in_bucket.arn  # ARN of the input bucket
}

output "out_bucket_arn" {
  value = aws_s3_bucket.out_bucket.arn  # ARN of the output bucket.
}

output "tmp_bucket_arn" {
  value = aws_s3_bucket.tmp_bucket.arn  # ARN of the temporary bucket.
}

output "export_bucket_arn" {
  value = aws_s3_bucket.export_bucket.arn  # ARN of the export bucket.
}