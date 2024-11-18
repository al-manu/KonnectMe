# modules/redshift_serverless/outputs.tf

output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.redshift_vpc.id
}

output "redshift_workgroup_endpoint" {
  description = "The Redshift Serverless Workgroup Endpoint"
  value       = aws_redshiftserverless_workgroup.redshift_workgroup.endpoint
}
