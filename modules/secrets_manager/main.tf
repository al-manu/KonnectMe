# modules/secrets_manager/main.tf
resource "aws_secretsmanager_secret" "redshift_admin_password" {
  name        = "redshift-admin-password"
  description = "Redshift admin password for database connections"
}

resource "random_password" "redshift_admin_password" {
  length  = 16
  special = true
  upper   = true
  lower   = true
  number  = true
}

resource "aws_secretsmanager_secret_version" "redshift_admin_password_version" {
  secret_id     = aws_secretsmanager_secret.redshift_admin_password.id
  secret_string = jsonencode({
    password = random_password.redshift_admin_password.result
  })
}

