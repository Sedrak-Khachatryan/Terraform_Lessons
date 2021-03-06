provider "aws" {}


resource "aws_instance" "My_Ubuntu" {
  count         = 2
  ami           = "ami-07dd19a7900a1f049"
  instance_type = "t2.micro"
}

resource "aws_instance" "My_Amazon" {
  ami           = "ami-0e999cbd62129e3b1"
  instance_type = "t2.micro"

  tags = {
    Name    = "My Amazon Server"
    Owner   = "Sedrak"
    Project = "My Terraform Lesson"
  }
}
