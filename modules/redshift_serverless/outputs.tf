# modules/redshift_serverless/outputs.tf

# Output the Redshift workgroup name
output "workgroup_name" {
  value = aws_redshiftserverless_workgroup.redshift_workgroup.workgroup_name
}

# Output the Redshift namespace name
output "namespace_name" {
  value = aws_redshiftserverless_namespace.redshift_namespace.namespace_name
}
