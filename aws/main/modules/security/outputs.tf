output "instance_sg_id" {
  value = aws_security_group.instance_access.id
}

output "lb_sg_id" {
  value = aws_security_group.lb_sg.id
}

output "test_sg_id" {
  value = aws_security_group.test_sg.id
}