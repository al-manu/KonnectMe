# outputs.tf (Root)
output "vpc_id" {
  description = "The ID of the created VPC."
  value       = module.vpc.vpc_id
}

output "subnet_ids" {
  description = "The subnet IDs created for Redshift."
  value       = module.vpc.subnet_ids
}

output "redshift_namespace_id" {
  description = "The ID of the Redshift Serverless namespace."
  value       = module.redshift.namespace_id
}

output "redshift_workgroup_id" {
  description = "The ID of the Redshift Serverless workgroup."
  value       = module.redshift.workgroup_id
}

output "lambda_rotation_function_arn" {
  description = "The ARN of the Lambda function for password rotation."
  value       = module.lambda_rotation.lambda_function_arn
}
