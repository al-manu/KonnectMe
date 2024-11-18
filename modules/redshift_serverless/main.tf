# modules/redshift_serverless/main.tf

resource "aws_secretsmanager_secret" "redshift_credentials" {
  name = "redshift-db-credentials"
}

resource "aws_secretsmanager_secret_version" "redshift_credentials_version" {
  secret_id     = aws_secretsmanager_secret.redshift_credentials.id
  secret_string = jsonencode({
    username = var.redshift_master_username
    password = var.redshift_master_password
  })
}

resource "aws_redshiftserverless_namespace" "redshift_namespace" {
  namespace_name = var.redshift_db_name
  db_name        = var.redshift_db_name
  admin_username = var.redshift_master_username
  # admin_password is not used directly, it's managed via Secrets Manager
}

resource "aws_redshiftserverless_workgroup" "redshift_workgroup" {
  workgroup_name    = "${var.redshift_db_name}-workgroup"
  namespace_name    = aws_redshiftserverless_namespace.redshift_namespace.namespace_name
  base_capacity     = 0
  security_group_ids = [aws_security_group.redshift_sg.id]
  subnet_ids = [aws_subnet.redshift_subnet.id]
}

resource "aws_security_group" "redshift_sg" {
  name        = "redshift-sg"
  description = "Security group for Redshift"
  vpc_id      = var.vpc_id
}

resource "aws_subnet" "redshift_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.0.0/24"  # Adjust as needed
}

resource "aws_redshiftserverless_endpoint" "redshift_endpoint" {
  workgroup_name = aws_redshiftserverless_workgroup.redshift_workgroup.workgroup_name
}

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

resource "aws_iam_role_policy_attachment" "redshift_s3_attach" {
  policy_arn = aws_iam_policy.redshift_s3_policy.arn
  role       = aws_iam_role.redshift_role.name
}
