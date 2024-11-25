output "namespace_name" {
  value       = aws_redshiftserverless_namespace.namespace.namespace_name
  description = "The name of the Redshift namespace"
}

output "workgroup_name" {
  value       = aws_redshiftserverless_workgroup.workgroup.workgroup_name
  description = "The name of the Redshift workgroup"
}

output "workgroup_endpoint" {
  value       = aws_redshiftserverless_workgroup.workgroup.endpoint.name
  description = "The endpoint for connecting to the Redshift workgroup"
}

output "workgroup_arn" {
  value       = aws_redshiftserverless_workgroup.workgroup.workgroup_arn
  description = "The ARN of the Redshift workgroup"
}
