# # modules/vpc/main.tf

# # Create VPC
# resource "aws_vpc" "redshift_vpc" {
#   cidr_block = var.cidr_block
#   enable_dns_support = true
#   enable_dns_hostnames = true
#   tags = {
#     Name = "RedshiftVPC"
#   }
# }

# # Create Public Subnet
# resource "aws_subnet" "redshift_subnet_public" {
#   vpc_id                  = aws_vpc.redshift_vpc.id
#   cidr_block              = var.public_subnet_cidr
#   availability_zone       = var.public_subnet_az
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "RedshiftPublicSubnet"
#   }
# }

# # Create Private Subnet
# resource "aws_subnet" "redshift_subnet_private" {
#   vpc_id                  = aws_vpc.redshift_vpc.id
#   cidr_block              = var.private_subnet_cidr
#   availability_zone       = var.private_subnet_az
#   tags = {
#     Name = "RedshiftPrivateSubnet"
#   }
# }

# # Create Security Group for Redshift
# resource "aws_security_group" "redshift_sg" {
#   name        = "redshift-sg"
#   description = "Security group for Redshift"
#   vpc_id      = aws_vpc.redshift_vpc.id
# }




resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "this" {
  count = length(var.subnet_cidr_blocks)  # Create subnets based on the number of CIDR blocks passed
  vpc_id = aws_vpc.this.id
  cidr_block = element(var.subnet_cidr_blocks, count.index)
  availability_zone = element(var.availability_zones, count.index)  # Ensure AZs match subnet count
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    Name = "subnet-${count.index}"
  }
}

resource "aws_security_group" "this" {
  vpc_id = aws_vpc.this.id
  name = var.security_group_name
  description = "Allow Redshift inbound traffic"

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_cidr_blocks
  }
}

# output "vpc_id" {
#   value = aws_vpc.this.id
# }

# output "subnet_ids" {
#   value = aws_subnet.this[*].id
# }

# output "security_group_ids" {
#   value = aws_security_group.this.id
# }
