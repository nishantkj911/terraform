resource "aws_security_group" "instance_access" {
  name = "sg_instance_access"
}

resource "aws_security_group_rule" "ssh_ingress" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  security_group_id = aws_security_group.instance_access.id
  cidr_blocks = [aws_subnet.my_subnet.cidr_block]
}

output "instance_sg_id" {
  value = aws_security_group.instance_access.id
}