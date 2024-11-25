# # outputs.tf - Output useful information after resources are created

# # Redshift Serverless Outputs
# output "redshift_namespace_name" {
#   description = "The name of the Redshift Serverless namespace"
#   value       = module.redshift.namespace_name
# }

# output "redshift_workgroup_name" {
#   description = "The name of the Redshift Serverless workgroup"
#   value       = module.redshift.workgroup_name
# }

# output "redshift_endpoint" {
#   description = "The Redshift Serverless endpoint"
#   value       = module.redshift.db_host
# }

# output "redshift_db_name" {
#   description = "The Redshift database name"
#   value       = module.redshift.db_name
# }

# # IAM Role Outputs
# output "iam_role_arn" {
#   description = "The ARN of the IAM role used by Redshift"
#   value       = module.iam.iam_role_arn
# }

# # Secrets Manager Outputs
# output "secret_arn" {
#   description = "The ARN of the secret storing database credentials"
#   value       = module.secrets_manager.secret_arn
# }

# # VPC Outputs
# output "vpc_id" {
#   description = "The VPC ID"
#   value       = module.vpc.vpc_id
# }

# output "subnet_id" {
#   description = "The subnet ID"
#   value       = module.vpc.subnet_id
# }


# Outputs
# output "vpc_id" {
#   value = module.redshift.vpc_id
# }

# output "private_subnet_ids" {
#   value = module.redshift.private_subnet_ids
# }

# output "redshift_role_arn" {
#   value = module.redshift.redshift_role_arn
# }

# output "redshift_endpoint" {
#   value = module.redshift.redshift_endpoint
# }
