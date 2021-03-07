#..............................................
# My Terraform
#
# Terraform Conditions and Lookups
#..............................................

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_webserver1" {
  ami = "ami-03a71cec707bfc3d7"
  #instance_type = (var.env == "prod" ? "t2.large" : "t2.micro")
  istance_type = var.env == "prod" ? var.ec2_size["prod"] : var.ec2_size["dev"]

  tags = {
    Name  = "${var.env}-server"
    Owner = var.env == "prod" ? var.prod_owner : var.noprod_owner
  }
}

resource "aws_instance" "my_webserver2" {
  ami           = "ami-03a71cec707bfc3d7"
  instance_type = lookup(var.ec2_size, var.env)

  tags = {
    Name  = "${var.env}-server"
    Owner = var.env == "prod" ? var.prod_owner : var.noprod_owner
  }
}

resource "aws_instance" "my_dev_bastion" {
  count         = var.env == "dev" ? 1 : 0
  ami           = "ami-03a71cec707bfc3d7"
  instance_type = "t2.micro"

  tags = {
    Name = "Bastion Server for Dev-server"
  }
}

resource "aws_security_group" "my_webserver" {
  name = "Dynamic Security Group"

  dynamic "ingress" {
    for_each = lookup(var.allow_port_list, var.env)
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Dynamic Server SecurityGroup"
    Owner = "Sedrak Khachatryan"
  }
}
