# # Create a Redshift Serverless Namespace
# resource "aws_redshiftserverless_namespace" "namespace" {
#   namespace_name = var.namespace_name
#   log_exports    = var.log_exports # Enable log exports for auditing

#   # Optional IAM roles for integration
#   iam_roles      = [module.iam.redshift_role_arn] # Add IAM role here

#   tags = var.tags
# }

# # Create a Redshift Serverless Workgroup
# resource "aws_redshiftserverless_workgroup" "workgroup" {
#   workgroup_name       = var.workgroup_name
#   namespace_name       = aws_redshiftserverless_namespace.namespace.namespace_name
#   base_capacity        = var.base_capacity # Specify compute capacity
#   enhanced_vpc_routing = true              # Enforce VPC-based routing for security
#   subnet_ids           = var.subnet_ids    # VPC subnets for Redshift access
#   security_group_ids   = var.security_group_ids

#   tags = var.tags
# }




# Provider configuration
provider "aws" {
  region = var.region  # AWS region specified in variables.tf
}

# ------------------------
# VPC Creation
# ------------------------

# Create the VPC for our Redshift resources
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr  # CIDR block for the VPC
  enable_dns_support   = true          # Enable DNS support
  enable_dns_hostnames = true          # Enable DNS hostnames

  tags = merge(var.tags, { "Name" = "${var.project_name}-vpc" })
}

# ------------------------
# Private Subnets Creation
# ------------------------

# Create private subnets for Redshift in different availability zones
resource "aws_subnet" "private" {
  count                  = length(var.private_subnet_cidrs)  # Create subnet for each CIDR block
  vpc_id                 = aws_vpc.main.id                  # VPC ID where the subnet will be created
  cidr_block             = var.private_subnet_cidrs[count.index]  # Subnet CIDR block
  availability_zone      = element(var.availability_zones, count.index)  # AZ for the subnet
  map_public_ip_on_launch = false

  tags = merge(var.tags, { "Name" = "${var.project_name}-private-subnet-${count.index + 1}" })
}

# ------------------------
# Internet Gateway Creation (For NAT Gateway)
# ------------------------

# Create an Internet Gateway for the VPC (Required for NAT Gateway)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, { "Name" = "${var.project_name}-igw" })
}

# ------------------------
# NAT Gateway Creation
# ------------------------

# Create an Elastic IP for the NAT Gateway
resource "aws_eip" "nat" {
  count = 1  # Only one Elastic IP needed for NAT
  tags  = merge(var.tags, { "Name" = "${var.project_name}-nat-eip-${count.index + 1}" })
}

# Create the NAT Gateway itself, assigning the Elastic IP
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat[0].id  # Assign the Elastic IP
  subnet_id     = element(aws_subnet.private.*.id, 0)  # Place NAT Gateway in the first private subnet

  tags = merge(var.tags, { "Name" = "${var.project_name}-nat" })
}

# ------------------------
# Route Table and Association
# ------------------------

# Create a route table for private subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, { "Name" = "${var.project_name}-private-rt" })
}

# Associate route table with private subnets
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)  # Create association for each private subnet
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

# ------------------------
# IAM Role Creation for Redshift
# ------------------------

# IAM role that Redshift will use for assuming permissions
# IAM Role that Redshift will use for assuming permissions
resource "aws_iam_role" "redshift_role" {
  name               = var.iam_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "redshift.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(var.tags, { "Name" = "${var.project_name}-redshift-role" })
}




# ------------------------
# Secrets Manager Configuration
# ------------------------

# Create a secret in Secrets Manager to store DB credentials
resource "aws_secretsmanager_secret" "db_credentials" {
  name        = var.secret_name
  description = var.secret_description

  tags = merge(var.tags, { "Name" = "${var.project_name}-secret" })
}

# Add the DB credentials (username and password) to the secret
resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({ username = var.db_username, password = var.db_password })
}

# ------------------------
# Redshift Serverless Configuration
# ------------------------

# Define Security Group for Redshift
resource "aws_security_group" "redshift" {
  vpc_id = aws_vpc.main.id

  ingress {
    description = "Allow Redshift connection"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = var.allowed_ips # IPs allowed to connect to Redshift
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { "Name" = "${var.project_name}-redshift-sg" })
}

# Define the Redshift Serverless Workgroup
# Create the Redshift Serverless workgroup
resource "aws_redshiftserverless_workgroup" "redshift_serverless" {
  workgroup_name        = var.workgroup_name
  base_capacity         = var.base_capacity
  enhanced_vpc_routing = var.enhanced_vpc_routing
  namespace_name        = var.namespace_name
  # log_exports           = var.log_exports # Correct usage of log_exports as a list of strings

  # Attach security groups (this should be vpc_security_group_ids, not vpc_security_group_id)
  # vpc_security_group_ids = [aws_security_group.redshift.id]  # Attach VPC security group(s)

  tags = merge(var.tags, { "Name" = "${var.project_name}-redshift-workgroup" })
}

