# Outputs to share information from this module

# Output the VPC ID
output "vpc_id" {
  value = aws_vpc.main.id
}

# Output the private subnet IDs
output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

# Output the IAM role ARN for Redshift
output "redshift_role_arn" {
  value = aws_iam_role.redshift_role.arn
}

# Output the Redshift endpoint (hostname) for connection
output "redshift_endpoint" {
  value = aws_redshiftserverless_workgroup.redshift_serverless.endpoint
}
