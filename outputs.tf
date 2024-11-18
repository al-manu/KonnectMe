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

# Outputs (optional)# outputs.tf (Root Module)

# Output the VPC ID
output "vpc_id" {
  value = module.vpc.vpc_id
}

# Output the public subnet ID
output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

# Output the private subnet ID
output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}

# Output the Redshift Workgroup Name
output "redshift_workgroup_name" {
  value = module.redshift_serverless.workgroup_name
}
