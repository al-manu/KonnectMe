# modules/lambda_rotation/outputs.tf
output "lambda_function_arn" {
  description = "The ARN of the Lambda function."
  value       = aws_lambda_function.password_rotation_lambda.arn
}
