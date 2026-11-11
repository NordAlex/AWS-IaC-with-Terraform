output "vpc_id" {
  description = "ID of the created VPC."
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "Cidr of the created VPC."
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the three public subnets."
  value       = aws_subnet.public[*].id
}

output "public_subnet_cidr_block" {
  description = "CIDR of the three public subnets."
  value       = aws_subnet.public[*].cidr_block
}

output "public_subnet_availability_zone" {
  description = "Availibility zone of the three public subnets."
  value       = aws_subnet.public[*].availability_zone
}

output "internet_gateway_id" {
  description = "ID of the attached Internet Gateway."
  value       = aws_internet_gateway.main.id
}

output "routing_table_id" {
  description = "ID of the route table associated with the public subnets."
  value       = aws_route_table.route-table.id
}
