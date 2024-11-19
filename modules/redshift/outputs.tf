# modules/redshift/outputs.tf
output "namespace_id" {
  description = "The Redshift namespace ID."
  value       = aws_redshiftserverless_namespace.this.id
}

output "workgroup_id" {
  description = "The Redshift workgroup ID."
  value       = aws_redshiftserverless_workgroup.this.id
}
