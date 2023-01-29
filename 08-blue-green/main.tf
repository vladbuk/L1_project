provider "aws" {
    region = "eu-central-1"
    profile = "default"
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

#-------------------------------------------------#

resource "aws_vpc" "main_vpc" {
  cidr_block = "172.16.0.0/16"
  tags = {
    "Name" = "main_vpc"
    "Env" = "test"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "172.16.1.0/24"
  availability_zone = data.aws_availability_zones.working_zones.names[0]
  tags = {
    "Name" = "Subnet1"
  }
}

resource "aws_network_interface" "ether1" {
  subnet_id = aws_subnet.subnet1.id
  private_ips = [ "172.16.1.10" ]
  # security_groups = [ aws_security_group.allow_ports.id ]
  tags = {
    "Name" = "primary_net_interface"
  }
}

resource "aws_internet_gateway" "main_gw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "main_gateway"
  }
}

resource "aws_route_table" "main_route" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gw.id
  }
  tags = {
      Name = "main_route"
  }
}

#-------------------------------------------------#

# resource "aws_instance" "ubuntu" {
#   ami = data.aws_ami.ubuntu20_latest.id
#   instance_type = "t2.micro"
#   key_name = "ter_aws_key.pem"
#   # vpc_security_group_ids = [ aws_security_group.allow_ports.id ]
#   network_interface {
#     network_interface_id = aws_network_interface.ether1.id
#     device_index = "0"
#   }
#   tags = {
#     Name = "ubuntu"
#   }
# }

#-------------------------------------------------#

# resource "aws_security_group" "allow_ports" {
#   name        = "allow_in_ports"
#   description = "Open only needed ports" 

#   dynamic "ingress" {
#     for_each = ["22", "80", "8080"]
#     content {
#       description      = "open tcp ports"
#       from_port        = ingress.value
#       to_port          = ingress.value
#       protocol         = "tcp"
#       cidr_blocks      = ["0.0.0.0/0"]
#     }
#   }

#   ingress {
#     description      = "open icmp traffic"
#     from_port        = -1
#     to_port          = -1
#     protocol         = "icmp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   egress {
#     description = "Outbound all packets"
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "allow_in_ports"
#   }
# }

#----------------------------------------#

# output "instance_ubuntu_public_ip" {
#   value = aws_instance.ubuntu.public_ip
# }

output "aws_ami" {
    value = data.aws_ami.ubuntu20_latest.id
}

output "aws_availability_zones" {
    value = data.aws_availability_zones.working_zones.names 
}
