# Output the Secret ARN
output "redshift_secret_arn" {
  value       = aws_secretsmanager_secret.redshift_secret.arn
  description = "The ARN of the Redshift secret in Secrets Manager"
}

# Output the Secret Name
output "redshift_secret_name" {
  value       = aws_secretsmanager_secret.redshift_secret.name
  description = "The name of the Redshift secret in Secrets Manager"
}
