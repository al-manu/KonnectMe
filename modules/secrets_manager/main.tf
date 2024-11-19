resource "aws_secretsmanager_secret" "this" {
  name        = var.secret_name
  description = "Redshift Admin credentials"
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = jsonencode({
    username = "redshift-admin"
    password = "initialPassword123!"  # This will be updated later
    dbname   = "mydb"
  })
}

# output "secret_arn" {
#   value = aws_secretsmanager_secret.this.arn
# }
