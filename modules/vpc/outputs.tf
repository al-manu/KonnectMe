# # modules/vpc/outputs.tf

# output "vpc_id" {
#   value = aws_vpc.redshift_vpc.id
# }

# output "public_subnet_id" {
#   value = aws_subnet.redshift_subnet_public.id
# }

# output "private_subnet_id" {
#   value = aws_subnet.redshift_subnet_private.id
# }

# output "security_group_id" {
#   value = aws_security_group.redshift_sg.id
# }

output "vpc_id" {
  value = aws_vpc.this.id
}

output "subnet_ids" {
  value = aws_subnet.this[*].id
}

output "security_group_ids" {
  value = aws_security_group.this.id
}
