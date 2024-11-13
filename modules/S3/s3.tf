resource "aws_s3_bucket" "in" {
  bucket = var.in_bucket_name
}

resource "aws_s3_bucket" "out" {
  bucket = var.out_bucket_name
}

resource "aws_s3_bucket" "tmp" {
  bucket = var.tmp_bucket_name
}

resource "aws_s3_bucket" "export" {
  bucket = var.export_bucket_name
}