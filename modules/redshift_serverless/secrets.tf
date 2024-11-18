# modules/redshift_serverless/secrets.tf

resource "aws_secretsmanager_secret" "redshift_credentials" {
  name = "redshift-db-credentials"
}

resource "aws_secretsmanager_secret_version" "redshift_credentials_version" {
  secret_id     = aws_secretsmanager_secret.redshift_credentials.id
  secret_string = jsonencode({
    username = var.redshift_master_username
    password = var.redshift_master_password
  })
}
