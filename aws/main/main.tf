
/*# Creates a VPC
resource "aws_vpc" "network" {
  cidr_block = "10.0.0.0/16"
}*/

resource "aws_key_pair" "keypair" {
  public_key = file("${path.cwd}/.ssh/id_rsa.pub")
  key_name = "First Keypair"
}

resource "aws_instance" "test_instance" {
  ami = var.image_id
  instance_type = var.instance_type
  key_name = aws_key_pair.keypair.key_name
}

// TODO("Find automated way of filtering image IDs")