provider "aws" {}

resource "aws_instance" "t2micro_jenkins" {
    ami = "ami-0caef02b518350c8b"
    instance_type = "t2.micro"
    vpc_security_group_ids = [ aws_security_group.allow_http.id, aws_security_group.allow_ssh.id ]
    key_name = "ter_aws_key"
    tags = {
        Name = "t2micro_jenkins"
        Env = "test"
    }
    user_data = file("user_data_jenkins.sh")
    lifecycle {
      //prevent_destroy = true
      //create_before_destroy = true
    }
}

resource "aws_volume_attachment" "backup2gb" {
  device_name = "/dev/xvdb"
  volume_id   = "vol-0c42799db22d24fd5"
  instance_id = aws_instance.t2micro_jenkins.id
}


resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow http inbound traffic" 

  dynamic "ingress" {
    for_each = ["8080", "10500", "5000"]
    content {
      description      = "http from VPC"
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  }

  ingress {
    description      = "icmp from VPC"
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
    Name = "allow_http_https"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"  

  ingress {
    description      = "ssh from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}