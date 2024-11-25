# Create a Redshift Serverless Namespace
resource "aws_redshiftserverless_namespace" "namespace" {
  namespace_name = var.namespace_name
  log_exports    = var.log_exports # Enable log exports for auditing

  # Optional IAM roles for integration
  iam_roles      = [module.iam.redshift_role_arn] # Add IAM role here

  tags = var.tags
}

# Create a Redshift Serverless Workgroup
resource "aws_redshiftserverless_workgroup" "workgroup" {
  workgroup_name       = var.workgroup_name
  namespace_name       = aws_redshiftserverless_namespace.namespace.namespace_name
  base_capacity        = var.base_capacity # Specify compute capacity
  enhanced_vpc_routing = true              # Enforce VPC-based routing for security
  subnet_ids           = var.subnet_ids    # VPC subnets for Redshift access
  security_group_ids   = var.security_group_ids

  tags = var.tags
}
