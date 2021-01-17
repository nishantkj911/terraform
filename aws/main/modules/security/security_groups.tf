
resource "aws_security_group" "instance_access" {
  name = "sg_instance_access"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ssh_ingress" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  security_group_id = aws_security_group.instance_access.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https_egress" {
  type = "egress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  security_group_id = aws_security_group.instance_access.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "dns_egress" {
  from_port = 53
  protocol = "udp"
  security_group_id = aws_security_group.instance_access.id
  to_port = 53
  type = "egress"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "http_egress" {
  type = "egress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  security_group_id = aws_security_group.instance_access.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "lb_ingress" {
  source_security_group_id = aws_security_group.lb_sg.id
  protocol = "tcp"
  security_group_id = aws_security_group.instance_access.id
  type = "ingress"
  from_port = 80
  to_port = 80
}


// Loadbalancer SG and its rules
resource "aws_security_group" "lb_sg" {
  name = "sg_loadbalancer"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "http_ingress" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  security_group_id = aws_security_group.lb_sg.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https_ingress" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  security_group_id = aws_security_group.lb_sg.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group" "test_sg" {
  vpc_id = var.vpc_id
  name = "no_access_sg"
}