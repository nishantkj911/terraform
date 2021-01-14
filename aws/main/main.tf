
/*# Creates a VPC
resource "aws_vpc" "network" {
  cidr_block = "10.0.0.0/16"
}*/

// Create Security group module
module "sg_instance" {
  source = "modules\/network_and_security"
}

// Create Keypair and instance
resource "aws_key_pair" "keypair" {
  public_key = file("${path.cwd}/.ssh/id_rsa.pub")
  key_name = "First Keypair"
}

resource "aws_instance" "test_instance" {
  count = var.instance_count
  ami = var.image_id
  instance_type = var.instance_type
  key_name = aws_key_pair.keypair.key_name
  security_groups = [module.sg_instance.sg_id]
}

// TODO("Find automated way of filtering image IDs")

output "inventory" {
  value = templatefile("${path.cwd}/template.tmpl",
    {
      instances = aws_instance.test_instance
    }
  )
}