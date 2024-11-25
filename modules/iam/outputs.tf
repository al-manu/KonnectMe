# Output the Role ARN
output "redshift_role_arn" {
  value       = aws_iam_role.redshift_role.arn
  description = "The ARN of the IAM Role for Redshift"
}
