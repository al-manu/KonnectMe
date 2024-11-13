module "s3_buckets" {
  source = "./modules/S3"  # Path to the S3 module

  # Pass the required variables, which will be read from dev.tfvars
  in_bucket_name     = var.in_bucket_name
  out_bucket_name    = var.out_bucket_name
  tmp_bucket_name    = var.tmp_bucket_name
  export_bucket_name = var.export_bucket_name
}
