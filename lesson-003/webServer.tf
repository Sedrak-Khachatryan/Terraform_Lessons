#.........................................................
# My Terraform
#
#Build webServer during bootstrap
#.........................................................


provider "aws" {
  region = "us-west-1"
}


resource "aws_instance" "my_webserver" {
  ami                    = "ami-005c06c6de69aee84"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data              = file("user_data.sh")

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Sedrak"
  }
}



resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web Server SecurityGroup"
    Owner = "Sedrak"
  }
}
