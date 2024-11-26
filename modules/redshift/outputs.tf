# --------------------------------------------------------
# Outputs Module: Share Information from Resources
# --------------------------------------------------------

# Output the VPC ID for use in other modules or resources
output "vpc_id" {
  description = "The ID of the VPC created for Redshift Serverless"
  value       = aws_vpc.main.id
}

# Output the Private Subnet IDs
output "private_subnet_ids" {
  description = "A list of private subnet IDs created within the VPC"
  value       = aws_subnet.private[*].id
}

# Output the IAM Role ARN for Redshift
output "redshift_role_arn" {
  description = "The ARN of the IAM role assigned to Redshift Serverless for accessing AWS resources"
  value       = aws_iam_role.redshift_role.arn
}

# Output the Redshift Endpoint (Hostname)
output "redshift_endpoint" {
  description = "The endpoint (hostname) of the Redshift Serverless workgroup for client connection"
  value       = aws_redshiftserverless_workgroup.redshift_workgroup.endpoint
}

# Output the Redshift Namespace Name
output "redshift_namespace_name" {
  description = "The name of the Redshift Serverless namespace created for managing resources"
  value       = aws_redshiftserverless_namespace.redshift_namespace.namespace_name
}

# Output the KMS key ID for reference
output "kms_key_id" {
  description = "The ID of the KMS key created for Redshift encryption"
  value       = aws_kms_key.redshift_kms_key.id
}