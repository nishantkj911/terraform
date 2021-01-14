output "vpc_cidr" {
  value = aws_vpc.my_vpc.cidr_block
}

output "subnet_id" {
  value = aws_subnet.my_subnet.id
}