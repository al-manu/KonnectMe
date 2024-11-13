# Outputs from the S3 module
output "in_bucket_id" {
  description = "The ID of the input S3 bucket"
  value       = module.s3_buckets.in_bucket_id
}

output "out_bucket_id" {
  description = "The ID of the output S3 bucket"
  value       = module.s3_buckets.out_bucket_id
}

output "tmp_bucket_id" {
  description = "The ID of the temporary S3 bucket"
  value       = module.s3_buckets.tmp_bucket_id
}

output "export_bucket_id" {
  description = "The ID of the export S3 bucket"
  value       = module.s3_buckets.export_bucket_id
}