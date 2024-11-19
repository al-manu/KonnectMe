resource "aws_lambda_function" "this" {
  function_name = "redshift-password-rotation"
  role          = var.lambda_role_arn
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  timeout       = 60

  source_code_hash = filebase64sha256("lambda.zip")

  environment {
    variables = {
      SECRET_ARN = var.secret_arn
    }
  }
}

# output "lambda_function_name" {
#   value = aws_lambda_function.this.function_name
# }
