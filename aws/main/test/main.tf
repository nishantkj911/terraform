
/*# Creates a VPC
resource "aws_vpc" "network" {
  cidr_block = "10.0.0.0/16"
}*/

// Create Security group module
module "vpc_and_subnet" {
  source = "../modules/network"
}

module "security_groups" {
  source = "../modules/security"
  vpc_id = module.vpc_and_subnet.vpc_id
}

// Create Keypair and instance
resource "aws_key_pair" "keypair" {
  public_key = file("${path.cwd}/.ssh/id_rsa.pub")
  key_name = "First Keypair"
}

resource "aws_instance" "test_instance" {
  // TODO ("Write a script to shut down all VMs which I am managing. And also to start them using shell script")
  count = var.instance_count
  ami = var.image_id
  instance_type = var.instance_type
  key_name = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [module.security_groups.instance_sg_id]
  subnet_id = module.vpc_and_subnet.subnet_id
  user_data = <<EOF
  runcmd:
  - sudo yum install -y docker httpd
  EOF

  lifecycle {
    ignore_changes = [user_data]
  }
}

// TODO("Find automated way of filtering image IDs")

output "inventory" {
  value = templatefile("${path.cwd}/template.tmpl",
    {
      instances = aws_instance.test_instance
    }
  )
}

output "instance_ids" {
  value = join(" ", aws_instance.test_instance.*.id)
}