output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "redshift_private_subnets" {
  description = "IDs of the private subnets for Redshift"
  value       = aws_subnet.redshift_private[*].id
}
