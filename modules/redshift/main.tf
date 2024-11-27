# # --------------------------------------------------------
# # Provider Configuration
# # --------------------------------------------------------

# # Configure AWS provider to use the specified region
provider "aws" {
  region = var.region  # Set the AWS region from the input variables
}

# # --------------------------------------------------------
# # VPC and Networking Setup
# # --------------------------------------------------------

# # Create a Virtual Private Cloud (VPC) for the infrastructure
# resource "aws_vpc" "main" {
#   cidr_block           = var.vpc_cidr  # CIDR block for the VPC (e.g., 10.0.0.0/16)
#   enable_dns_support   = true          # Enable DNS support for internal service resolution
#   enable_dns_hostnames = true          # Enable DNS hostnames for instances within VPC

#   tags = merge(var.tags, { "Name" = "${var.project_name}-vpc" })  # Assign project name to VPC for easier identification
# }

# # Private Subnets for Redshift
# resource "aws_subnet" "private" {
#   count                 = length(var.private_subnet_cidrs)  # Create subnets for each CIDR block defined in variable
#   vpc_id                = aws_vpc.main.id
#   cidr_block            = var.private_subnet_cidrs[count.index]
#   availability_zone     = element(var.availability_zones, count.index)
#   map_public_ip_on_launch = false  # Ensure subnets don't get public IPs by default

#   tags = merge(var.tags, { "Name" = "${var.project_name}-private-subnet-${count.index + 1}" })  # Name subnets for easier identification
# }

# # Create Internet Gateway (for NAT Gateway) to allow private subnet access to the internet
# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.main.id

#   tags = merge(var.tags, { "Name" = "${var.project_name}-igw" })  # Attach project-specific tag
# }

# # Elastic IP for NAT Gateway
# resource "aws_eip" "nat" {
#   count = 1  # Typically, one EIP is sufficient for NAT Gateway
#   tags  = merge(var.tags, { "Name" = "${var.project_name}-nat-eip-${count.index + 1}" })
# }

# # NAT Gateway configuration for allowing outbound internet access from private subnets
# resource "aws_nat_gateway" "nat" {
#   allocation_id = aws_eip.nat[0].id
#   subnet_id     = element(aws_subnet.private[*].id, 0)

#   tags = merge(var.tags, { "Name" = "${var.project_name}-nat" })  # Attach project-specific tag
# }

# # Route Table for Private Subnets
# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.main.id

#   tags = merge(var.tags, { "Name" = "${var.project_name}-private-rt" })
# }

# # Associate Private Subnets with Route Table
# resource "aws_route_table_association" "private" {
#   count          = length(aws_subnet.private)  # Associate route table to all private subnets
#   subnet_id      = aws_subnet.private[count.index].id
#   route_table_id = aws_route_table.private.id
# }

# # --------------------------------------------------------
# # Security Groups
# # --------------------------------------------------------

# # Security Group configuration for Redshift
# resource "aws_security_group" "redshift" {
#   vpc_id = aws_vpc.main.id

#   # Allow inbound traffic on port 5439 (default Redshift port) from specified IPs
#   ingress {
#     description = "Allow Redshift connection"
#     from_port   = 5439
#     to_port     = 5439
#     protocol    = "tcp"
#     cidr_blocks = var.allowed_ips
#   }

#   # Allow all outbound traffic (for example, to other AWS services or external networks)
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = merge(var.tags, { "Name" = "${var.project_name}-redshift-sg" })
# }

# # --------------------------------------------------------
# # IAM Role and Policies for Redshift
# # --------------------------------------------------------

# # IAM Role for Redshift with the assume role policy
# resource "aws_iam_role" "redshift_role" {
#   name               = var.iam_role_name
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Effect    = "Allow"
#       Action    = "sts:AssumeRole"
#       Principal = { Service = "redshift.amazonaws.com" }
#     }]
#   })

#   tags = merge(var.tags, { "Name" = "${var.project_name}-redshift-role" })
# }

# # IAM Policy for accessing Secrets Manager (for Redshift credentials)
# resource "aws_iam_policy" "redshift_secret_access" {
#   name        = "RedshiftSecretAccess"
#   description = "Policy to allow Redshift to access secrets"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Effect   = "Allow"
#       Action   = "secretsmanager:GetSecretValue"
#       Resource = aws_secretsmanager_secret.db_credentials.arn
#     }]
#   })
# }

# # Attach IAM Policy to Redshift IAM Role
# resource "aws_iam_role_policy_attachment" "redshift_role_secret_access" {
#   policy_arn = aws_iam_policy.redshift_secret_access.arn
#   role       = aws_iam_role.redshift_role.name
# }

# # Attach CloudWatch Logs full access policy to Redshift IAM Role

# resource "aws_iam_role_policy_attachment" "cloudwatch_logs" {
#   role       = aws_iam_role.redshift_role.name
#   policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
# }

# # --------------------------------------------------------
# # Secrets Manager for Database Credentials
# # --------------------------------------------------------

# # Create a secret in AWS Secrets Manager to store Redshift DB credentials securely
# resource "aws_secretsmanager_secret" "db_credentials" {
#   name        = var.secret_name
#   description = var.secret_description
#   kms_key_id  = aws_kms_key.redshift_kms_key.id  # Use KMS encryption for added security

#   tags = merge(var.tags, { "Name" = "${var.project_name}-secret" })
# }

# # Create a version for the secret with actual DB credentials (username & password)
# resource "aws_secretsmanager_secret_version" "db_credentials_version" {
#   secret_id     = aws_secretsmanager_secret.db_credentials.id
#   secret_string = jsonencode({
#     username = var.db_username,
#     password = var.db_password
#   })
# }

# # --------------------------------------------------------
# # Redshift Serverless Configuration
# # --------------------------------------------------------

# # Create a Redshift Serverless namespace (container for workloads)
# resource "aws_redshiftserverless_namespace" "redshift_namespace" {
#   namespace_name = var.namespace_name
#   log_exports    = ["userlog", "connectionlog"]
#   iam_roles      = [aws_iam_role.redshift_role.arn]

#   tags = merge(var.tags, { "Name" = "${var.project_name}-redshift-namespace" })
# }

# # Create a Redshift Serverless workgroup (compute resource for queries)
# resource "aws_redshiftserverless_workgroup" "redshift_workgroup" {
#   workgroup_name       = var.workgroup_name
#   namespace_name       = aws_redshiftserverless_namespace.redshift_namespace.namespace_name
#   base_capacity        = var.base_capacity
#   enhanced_vpc_routing = var.enhanced_vpc_routing

#   depends_on = [aws_redshiftserverless_namespace.redshift_namespace]  # Ensure namespace is created first

#   tags = merge(var.tags, { "Name" = "${var.project_name}-redshift-workgroup" })
# }

# # --------------------------------------------------------
# # KMS Key for Redshift Database Credentials
# # --------------------------------------------------------

# # Create a KMS Key to encrypt Redshift database credentials
# resource "aws_kms_key" "redshift_kms_key" {
#   description             = "KMS key for Redshift Database Credentials"
#   deletion_window_in_days = 10

#   tags = merge(var.tags, { "Name" = "${var.project_name}-redshift-kms-key" })
# }

# # IAM Policy for allowing Redshift role to decrypt credentials using the KMS key
# resource "aws_iam_role_policy" "redshift_kms_policy" {
#   name   = "RedshiftKMSPolicy"
#   role   = aws_iam_role.redshift_role.name

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Effect   = "Allow"
#       Action   = "kms:Decrypt"
#       Resource = aws_kms_key.redshift_kms_key.arn
#     }]
#   })
# }

# # --------------------------------------------------------
# # Lambda Function for Password Rotation
# # --------------------------------------------------------

# # Create a Lambda function to rotate Redshift database credentials
# resource "aws_lambda_function" "password_rotation" {
#   function_name = "redshift-password-rotation"

#   role    = aws_iam_role.lambda_execution_role.arn
#   handler = "lambda_rotation.lambda_handler"
#   runtime = "python3.8"

#   # Assuming the Lambda code is packaged in a ZIP file
#   filename         = "${path.module}/../../scripts/lambda/lambda.zip"
#   source_code_hash = filebase64sha256("${path.module}/../../scripts/lambda/lambda.zip")

#   environment {
#     variables = {
#       SECRET_ID = aws_secretsmanager_secret.db_credentials.id
#     }
#   }
# }

# # IAM Role for Lambda Execution
# resource "aws_iam_role" "lambda_execution_role" {
#   name = "lambda-execution-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Action    = "sts:AssumeRole",
#       Principal = {
#         Service = "lambda.amazonaws.com"
#       },
#       Effect    = "Allow",
#       Sid       = ""
#     }]
#   })
# }

# # Attach necessary policies to the Lambda execution role
# resource "aws_iam_role_policy_attachment" "lambda_secrets_manager_policy" {
#   role       = aws_iam_role.lambda_execution_role.name
#   policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
# }

# resource "aws_iam_role_policy_attachment" "lambda_redshift_policy" {
#   role       = aws_iam_role.lambda_execution_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonRedshiftDataFullAccess"
# }

# resource "aws_iam_role_policy_attachment" "lambda_cloudwatch_policy" {
#   role       = aws_iam_role.lambda_execution_role.name
#   policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
# }

# # IAM Policy for Lambda to access KMS for decryption/encryption
# resource "aws_iam_role_policy" "lambda_kms_policy" {
#   name   = "lambda-kms-policy"
#   role   = aws_iam_role.lambda_execution_role.name

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect    = "Allow",
#       Action    = [
#         "kms:Decrypt",
#         "kms:Encrypt",
#         "kms:GenerateDataKey",
#         "kms:ReEncrypt*"
#       ],
#       Resource  = aws_kms_key.redshift_kms_key.arn
#     }]
#   })
# }

# # Inline IAM Policy for Redshift Serverless permissions to Lambda execution role
# resource "aws_iam_role_policy" "lambda_redshift_serverless_policy" {
#   name = "lambda-redshift-serverless-policy"
#   role = aws_iam_role.lambda_execution_role.id

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect    = "Allow",
#       Action    = [
#         "redshift-serverless:ListNamespaces",
#         "redshift-serverless:GetNamespace",
#         "redshift-serverless:ListWorkgroups",
#         "redshift-serverless:GetWorkgroup",
#         "redshift-serverless:DescribeEndpoints"
#       ],
#       Resource  = "*"
#     }]
#   })
# }

# # --------------------------------------------------------
# # Secret Rotation Configuration
# # --------------------------------------------------------

# # Configure Secrets Manager to automatically rotate credentials using Lambda
# resource "aws_secretsmanager_secret_rotation" "db_credentials_rotation" {
#   secret_id             = aws_secretsmanager_secret.db_credentials.id
#   rotation_lambda_arn   = aws_lambda_function.password_rotation.arn
#   rotation_rules {
#     automatically_after_days = 1  # Rotate every 1 day (adjust as needed)
#   }

#   depends_on = [aws_lambda_function.password_rotation]
# }

# # Grant Lambda function permission to be invoked by Secrets Manager
# resource "aws_lambda_permission" "secrets_manager_invocation" {
#   statement_id  = "AllowSecretsManagerInvocation"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.password_rotation.function_name
#   principal     = "secretsmanager.amazonaws.com"
# }
