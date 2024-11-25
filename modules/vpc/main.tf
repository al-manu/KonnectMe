# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.tags,
    { "Name" = "${var.project_name}-vpc" }
  )
}

# Create Private Subnets
resource "aws_subnet" "private" {
  count                  = length(var.private_subnet_cidrs)
  vpc_id                 = aws_vpc.main.id
  cidr_block             = var.private_subnet_cidrs[count.index]
  availability_zone      = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    { "Name" = "${var.project_name}-private-subnet-${count.index + 1}" }
  )
}

# Create an Internet Gateway (for NAT Gateway)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    { "Name" = "${var.project_name}-igw" }
  )
}

# Create NAT Gateway for Outbound Internet Access
resource "aws_eip" "nat" {
  count = 1 # Adjust for redundancy if needed
  tags  = merge(
    var.tags,
    { "Name" = "${var.project_name}-nat-eip-${count.index + 1}" }
  )
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat[0].id
  subnet_id     = element(aws_subnet.private.*.id, 0) # Place NAT in the first private subnet

  tags = merge(
    var.tags,
    { "Name" = "${var.project_name}-nat" }
  )
}

# Route Table for Private Subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    { "Name" = "${var.project_name}-private-rt" }
  )
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

# Security Group for Redshift
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

  tags = merge(
    var.tags,
    { "Name" = "${var.project_name}-redshift-sg" }
  )
}
