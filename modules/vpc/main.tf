# modules/vpc/main.tf

# Create VPC
resource "aws_vpc" "redshift_vpc" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "RedshiftVPC"
  }
}

# Create Public Subnet
resource "aws_subnet" "redshift_subnet_public" {
  vpc_id                  = aws_vpc.redshift_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.public_subnet_az
  map_public_ip_on_launch = true
  tags = {
    Name = "RedshiftPublicSubnet"
  }
}

# Create Private Subnet
resource "aws_subnet" "redshift_subnet_private" {
  vpc_id                  = aws_vpc.redshift_vpc.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = var.private_subnet_az
  tags = {
    Name = "RedshiftPrivateSubnet"
  }
}

# Create Security Group for Redshift
resource "aws_security_group" "redshift_sg" {
  name        = "redshift-sg"
  description = "Security group for Redshift"
  vpc_id      = aws_vpc.redshift_vpc.id
}

