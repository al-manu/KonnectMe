# --------------------------------------------------------
# Provider Configuration
# --------------------------------------------------------

provider "aws" {
  region = var.region  # AWS region specified in variables.tf
}

# --------------------------------------------------------
# VPC and Networking Setup
# --------------------------------------------------------

# Create a secure Virtual Private Cloud (VPC) for Redshift resources
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr  # CIDR block for the VPC
  enable_dns_support   = true          # Enable DNS support for resolving internal services
  enable_dns_hostnames = true          # Enable DNS hostnames

  tags = merge(var.tags, { "Name" = "${var.project_name}-vpc" })
}

# Private Subnets for Redshift
resource "aws_subnet" "private" {
  count                 = length(var.private_subnet_cidrs)  # Create subnets based on specified CIDR blocks
  vpc_id                = aws_vpc.main.id
  cidr_block            = var.private_subnet_cidrs[count.index]
  availability_zone     = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false  # Ensure private subnets don't get public IPs

  tags = merge(var.tags, { "Name" = "${var.project_name}-private-subnet-${count.index + 1}" })
}

# Internet Gateway for NAT Access (if needed)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, { "Name" = "${var.project_name}-igw" })
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  count = 1
  tags  = merge(var.tags, { "Name" = "${var.project_name}-nat-eip-${count.index + 1}" })
}

# NAT Gateway for Outbound Internet Access from Private Subnets
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat[0].id
  subnet_id     = element(aws_subnet.private[*].id, 0)

  tags = merge(var.tags, { "Name" = "${var.project_name}-nat" })
}

# Private Route Table for Subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, { "Name" = "${var.project_name}-private-rt" })
}

# Associate Private Subnets with Route Table
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

# --------------------------------------------------------
# Security Groups
# --------------------------------------------------------

# Security Group for Redshift
resource "aws_security_group" "redshift" {
  vpc_id = aws_vpc.main.id

  # Allow inbound access to Redshift from allowed IPs
  ingress {
    description = "Allow Redshift connection"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = var.allowed_ips
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { "Name" = "${var.project_name}-redshift-sg" })
}

# --------------------------------------------------------
# IAM Role and Policy for Redshift
# --------------------------------------------------------

# IAM Role for Redshift
resource "aws_iam_role" "redshift_role" {
  name               = var.iam_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "sts:AssumeRole"
      Principal = { Service = "redshift.amazonaws.com" }
    }]
  })

  tags = merge(var.tags, { "Name" = "${var.project_name}-redshift-role" })
}

# IAM Policy for Accessing Secrets Manager
resource "aws_iam_policy" "redshift_secret_access" {
  name        = "RedshiftSecretAccess"
  description = "Policy to allow Redshift to access secrets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "secretsmanager:GetSecretValue"
      Resource = aws_secretsmanager_secret.db_credentials.arn
    }]
  })
}

# Attach IAM Policy to the Role
resource "aws_iam_role_policy_attachment" "redshift_role_secret_access" {
  policy_arn = aws_iam_policy.redshift_secret_access.arn
  role       = aws_iam_role.redshift_role.name
}

# Attach the CloudWatch Logs full access policy to the Redshift IAM role
resource "aws_iam_role_policy_attachment" "cloudwatch_logs" {
  role       = aws_iam_role.redshift_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

# --------------------------------------------------------
# Secrets Manager for DB Credentials
# --------------------------------------------------------

# Store Database Credentials Securely
resource "aws_secretsmanager_secret" "db_credentials" {
  name        = var.secret_name
  description = var.secret_description
  kms_key_id  = aws_kms_key.redshift_kms_key.id  # Use the KMS key for encryption

  tags = merge(var.tags, { "Name" = "${var.project_name}-secret" })
}

# Add Secret Version with DB Credentials
resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = var.db_username,
    password = var.db_password
  })
}

# --------------------------------------------------------
# Redshift Serverless Namespace and Workgroup
# --------------------------------------------------------

# Create Redshift Namespace
resource "aws_redshiftserverless_namespace" "redshift_namespace" {
  namespace_name = var.namespace_name
  log_exports    = ["userlog", "connectionlog"]
  iam_roles      = [aws_iam_role.redshift_role.arn]
  tags = merge(var.tags, { "Name" = "${var.project_name}-redshift-namespace" })
}

# Create Redshift Workgroup
resource "aws_redshiftserverless_workgroup" "redshift_workgroup" {
  workgroup_name       = var.workgroup_name
  namespace_name       = aws_redshiftserverless_namespace.redshift_namespace.namespace_name
  base_capacity        = var.base_capacity
  enhanced_vpc_routing = var.enhanced_vpc_routing
  # subnet_ids           = aws_subnet.private[*].id
  # security_group_ids   = [aws_security_group.redshift.id]
  depends_on = [aws_redshiftserverless_namespace.redshift_namespace]  # Ensure namespace is created first
  tags = merge(var.tags, { "Name" = "${var.project_name}-redshift-workgroup" })
}


# Create a KMS Key for Secrets Manager encryption
resource "aws_kms_key" "redshift_kms_key" {
  description             = "KMS key for Redshift Database Credentials"
  deletion_window_in_days = 10

  tags = merge(var.tags, { "Name" = "${var.project_name}-redshift-kms-key" })
}

# IAM Policy to allow access to the KMS Key for decryption of credentials
resource "aws_iam_role_policy" "redshift_kms_policy" {
  name   = "RedshiftKMSPolicy"
  role   = aws_iam_role.redshift_role.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "kms:Decrypt"
        Resource = aws_kms_key.redshift_kms_key.arn
      }
    ]
  })
}





resource "aws_lambda_function" "password_rotation" {
  function_name = "redshift-password-rotation"

  role    = aws_iam_role.lambda_execution_role.arn
  handler = "lambda_rotation.lambda_handler"
  runtime = "python3.8"

  # Add the Lambda function code
  filename = "${path.module}/../../scripts/lambda/lambda.zip"  # Assuming you've packaged the code into a ZIP file
  source_code_hash = filebase64sha256("${path.module}/../../scripts/lambda/lambda.zip")

  environment {
    variables = {
      SECRET_ID = aws_secretsmanager_secret.db_credentials.id
    }
  }
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect    = "Allow",
        Sid       = ""
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_secrets_manager_policy" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

resource "aws_iam_role_policy_attachment" "lambda_redshift_policy" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRedshiftDataFullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_cloudwatch_policy" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}


resource "aws_secretsmanager_secret_rotation" "db_credentials_rotation" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  rotation_lambda_arn = aws_lambda_function.password_rotation.arn
  rotation_rules {
    automatically_after_days = 1  # Rotate every 30 days
  }
  depends_on = [aws_lambda_function.password_rotation]
}

resource "aws_lambda_permission" "secrets_manager_invocation" {
  statement_id  = "AllowSecretsManagerInvocation"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.password_rotation.function_name
  principal     = "secretsmanager.amazonaws.com"
}
