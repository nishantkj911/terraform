// Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_subnet" "my_subnet" {
  cidr_block = "10.0.123.0/27"
  vpc_id = aws_vpc.my_vpc.id
}