# modules/redshift_serverless/main.tf

# Create Redshift Serverless namespace
resource "aws_redshiftserverless_namespace" "redshift_namespace" {
  namespace_name = var.redshift_db_name
  db_name        = var.redshift_db_name
  admin_username = var.redshift_master_username
  # admin_password is handled via Secrets Manager
}

# Create Redshift Serverless workgroup
resource "aws_redshiftserverless_workgroup" "redshift_workgroup" {
  workgroup_name    = "${var.redshift_db_name}-workgroup"
  namespace_name    = aws_redshiftserverless_namespace.redshift_namespace.namespace_name
  base_capacity     = var.base_capacity
  security_group_ids = var.security_group_ids
  subnet_ids        = var.subnet_ids
}

# IAM Role for Redshift Serverless
resource "aws_iam_role" "redshift_role" {
  name = "redshift-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "redshift.amazonaws.com"
        }
        Effect    = "Allow"
      },
    ]
  })
}

# Attach a policy for S3 access to the IAM Role
resource "aws_iam_policy" "redshift_s3_policy" {
  name        = "redshift-s3-access-policy"
  description = "Allow Redshift access to S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:GetObject", "s3:ListBucket"]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::your-bucket-name/*"
      }
    ]
  })
}

# Attach policy to IAM role
resource "aws_iam_role_policy_attachment" "redshift_s3_attach" {
  policy_arn = aws_iam_policy.redshift_s3_policy.arn
  role       = aws_iam_role.redshift_role.name
}
