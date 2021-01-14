// Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_subnet" "my_subnet" {
  cidr_block = "10.0.123.0/27"
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_network_acl" "my_network_acl" {
  vpc_id = aws_vpc.my_vpc.id
  subnet_ids = [aws_subnet.my_subnet.id]
}

resource "aws_network_acl_rule" "allow_all_ingress" {
  network_acl_id = aws_network_acl.my_network_acl.id
  protocol = "all"
  rule_action = "allow"
  rule_number = 100
}

resource "aws_network_acl_rule" "allow_all_egress" {
  network_acl_id = aws_network_acl.my_network_acl.id
  protocol = "all"
  egress = true
  rule_action = "allow"
  rule_number = 500
}

resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id
}