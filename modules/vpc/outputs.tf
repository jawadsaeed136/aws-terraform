output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public : subnet.id]
  description = "List of IDs of public subnets"
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.private : subnet.id]
  description = "List of IDs of private subnets"
}

output "vpc_id" {
  value = aws_vpc.main.id
  description = "ID of the VPC"
}


