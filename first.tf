provider "aws" {}

resource "aws_instance" "t2micro_ubuntu22" {
    count = 1
    ami = "ami-0caef02b518350c8b"
    instance_type = "t2.micro"
    vpc_security_group_ids = [ aws_security_group.allow_http.id ]
    tags = {
        Name = "t2micro_ubuntu22"
        Env = "test"
    }
    user_data = <<EOF
    #!/bin/bash
    sudo apt update
    sudo apt install -y apache2
    myip=$(curl ifconfig.io)
    echo "<h1>My webserver running on IP: $myip</h1><p>builded by Terraform</p>" | sudo tee /var/www/html/index.html
    sudo systemctl enable apache2.service --now
EOF
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

  ingress {
    description      = "http from VPC"
    from_port        = -1
    to_port          = -1
    protocol         = "icmp"
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