# modules/secrets_manager/outputs.tf
output "secret_arn" {
  description = "The ARN of the Secrets Manager secret."
  value       = aws_secretsmanager_secret.redshift_admin_password.arn
}
