# Main VPC Resource
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.common_tags, {
    "Name" = "Main VPC"
  })
}

# Private Subnets for Redshift
resource "aws_subnet" "redshift_private" {
  count      = var.redshift_subnet_count
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr, 3, count.index + 4)
  map_public_ip_on_launch = false

  tags = merge(var.common_tags, {
    "Name" = "Redshift Private Subnet ${count.index + 1}"
  })
}

# Internet Gateway (for public connectivity if needed)
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.common_tags, {
    "Name" = "Main IGW"
  })
}

# Route Table for Private Subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.common_tags, {
    "Name" = "Private Route Table"
  })
}

# Associate Private Subnets with Route Table
resource "aws_route_table_association" "private_subnets" {
  count          = var.redshift_subnet_count
  subnet_id      = aws_subnet.redshift_private[count.index].id
  route_table_id = aws_route_table.private.id
}
