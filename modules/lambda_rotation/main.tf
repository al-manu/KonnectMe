# modules/lambda_rotation/main.tf
resource "aws_lambda_function" "password_rotation_lambda" {
  filename         = "lambda_rotation.zip" # Ensure this is zipped
  function_name    = "redshift-password-rotation"
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "lambda_function.lambda_handler" # Entry point for Lambda
  runtime          = "python3.8"
  timeout          = 60
  memory_size      = 128
  environment {
    variables = {
      SECRET_ARN = var.secret_arn
    }
  }
}

resource "aws_cloudwatch_event_rule" "rotation_event" {
  name        = "password-rotation-schedule"
  description = "Schedule for rotating Redshift admin password"
  schedule_expression = "rate(30 days)" # You can adjust the schedule as needed
}

resource "aws_cloudwatch_event_target" "rotation_target" {
  rule      = aws_cloudwatch_event_rule.rotation_event.name
  target_id = "password_rotation"
  arn       = aws_lambda_function.password_rotation_lambda.arn
}

resource "aws_lambda_permission" "allow_event_trigger" {
  statement_id  = "AllowCloudWatchEventsInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.password_rotation_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.rotation_event.arn
}

output "lambda_function_arn" {
  description = "The ARN of the Lambda function."
  value       = aws_lambda_function.password_rotation_lambda.arn
}
