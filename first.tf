provider "aws" {}

resource "aws_instance" "t2micro_ubuntu22" {
    count = 1
    ami = "ami-0caef02b518350c8b"
    instance_type = "t2.micro"
    tags = {
        Name = "t2micro_ubuntu22"
        Env = "test"
    }
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow http inbound traffic"  
  ingress {
    description      = "http from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http"
  }
}