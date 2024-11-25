# Create a Secret in AWS Secrets Manager
resource "aws_secretsmanager_secret" "redshift_secret" {
  name        = "${var.project_name}-redshift-secret"
  description = "Stores credentials for Redshift database"
  tags        = var.tags
}

# Store Initial Secret Value
resource "aws_secretsmanager_secret_version" "redshift_secret_version" {
  secret_id = aws_secretsmanager_secret.redshift_secret.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    host     = var.db_host
    port     = var.db_port
    database = var.db_name
  })
}

# Optional: Lambda Function for Automatic Password Rotation
resource "aws_lambda_function" "rotation_function" {
  count = var.enable_rotation ? 1 : 0

  filename         = var.lambda_rotation_zip
  function_name    = "${var.project_name}-rotation-function"
  role             = var.lambda_execution_role_arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = filebase64sha256(var.lambda_rotation_zip)

  tags = var.tags
}

# Attach Rotation Policy to Secret
resource "aws_secretsmanager_secret_rotation" "rotation" {
  count = var.enable_rotation ? 1 : 0

  secret_id          = aws_secretsmanager_secret.redshift_secret.id
  rotation_lambda_arn = aws_lambda_function.rotation_function.arn
  rotation_rules {
    automatically_after_days = var.rotation_interval_days
  }
}
