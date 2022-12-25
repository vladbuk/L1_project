provider "aws" {
    region = "eu-central-1"
    profile = "vladbuk"
    shared_credentials_files = [ "$HOME/.aws/credentials" ]
}

data "aws_ami" "ubuntu20_latest" {
    owners = [ "099720109477" ]
    most_recent = true
    
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
}

data "aws_availability_zones" "working_zones" {}

resource "aws_security_group" "allow_ports" {
  name        = "allow_in_ports"
  description = "Allow particular inbound traffic" 

  dynamic "ingress" {
    for_each = ["22", "80", "8080", "3000"]
    content {
      description      = "open tcp ports"
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  }

  ingress {
    description      = "open icmp traffic"
    from_port        = -1
    to_port          = -1
    protocol         = "icmp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description = "Outbound all packets"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_in_ports"
  }
}





output "aws_ami" {
    value = data.aws_ami.ubuntu20_latest.id
}

output "aws_availability_zones" {
    value = data.aws_availability_zones.working_zones.names 
}