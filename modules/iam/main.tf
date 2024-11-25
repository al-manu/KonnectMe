# Create IAM Role for Redshift Serverless
resource "aws_iam_role" "redshift_role" {
  name               = "${var.project_name}-redshift-role"
  assume_role_policy = data.aws_iam_policy_document.redshift_assume_role_policy.json

  tags = var.tags
}

# Trust Policy for Redshift to Assume Role
data "aws_iam_policy_document" "redshift_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["redshift-serverless.amazonaws.com"]
    }
  }
}

# Attach Policy to Allow S3 Access for Redshift
resource "aws_iam_policy" "s3_access_policy" {
  name        = "${var.project_name}-s3-access-policy"
  description = "Policy to allow Redshift to access S3"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:GetObject", "s3:ListBucket"]
        Effect   = "Allow"
        Resource = var.s3_bucket_arns
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
  role       = aws_iam_role.redshift_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

# Attach AWS Managed Glue Policy for Redshift Integration
resource "aws_iam_role_policy_attachment" "attach_glue_policy" {
  role       = aws_iam_role.redshift_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}
