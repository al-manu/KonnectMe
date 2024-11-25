# Output the VPC ID
output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the created VPC"
}

# Output Private Subnet IDs
output "private_subnet_ids" {
  value       = aws_subnet.private[*].id
  description = "List of private subnet IDs"
}

# Output Security Group for Redshift
output "redshift_security_group_id" {
  value       = aws_security_group.redshift.id
  description = "The ID of the Redshift security group"
}
