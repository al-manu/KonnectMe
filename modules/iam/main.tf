# modules/iam/main.tf
resource "aws_iam_role" "lambda_execution_role" {
  name               = "lambda_execution_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions   = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "lambda_secretsmanager_policy" {
  name        = "lambda_secretsmanager_policy"
  description = "Policy to allow Lambda to interact with Secrets Manager"
  policy      = data.aws_iam_policy_document.lambda_secretsmanager_policy.json
}

data "aws_iam_policy_document" "lambda_secretsmanager_policy" {
  statement {
    actions   = ["secretsmanager:GetSecretValue", "secretsmanager:PutSecretValue"]
    resources = [aws_secretsmanager_secret.redshift_admin_password.arn]
  }
}

resource "aws_iam_policy_attachment" "lambda_secretsmanager_policy_attachment" {
  name       = "lambda-secretsmanager-policy-attachment"
  policy_arn = aws_iam_policy.lambda_secretsmanager_policy.arn
  roles      = [aws_iam_role.lambda_execution_role.name]
}

output "lambda_role_arn" {
  description = "The ARN of the Lambda execution role."
  value       = aws_iam_role.lambda_execution_role.arn
}
