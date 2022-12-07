provider "aws" {
  region = "eu-central-1"
  profile = "vladbuk"
  shared_credentials_files = [ "$HOME/.aws/credentials" ]
}

resource "aws_instance" "jenkins_agent_1" {
  ami = "ami-06148e0e81e5187c8"
  instance_type = "t2.micro"
  key_name = "ter_aws_key"
  security_groups = [ aws_security_group.allowed_ports.id ]
  tags = {
    Name = "jenkins_agent_1"
    Label = "docker"
  }
  user_data = file("user_data.sh")
}

resource "aws_security_group" "allowed_ports" {
  name = "allowed_ports"
  description = "ports opened on instance"
  tags = {
    "Name" = "allowed_ports"
  }

  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "allow ssh"
    from_port = 22
    protocol = "tcp"
    to_port = 22
  }

  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "allow all packets out"
    from_port = 0
    protocol = "-1"
    to_port = 0
  }
}

data "aws_route53_zone" "selected" {
  name = "vladbuk.site."
  private_zone = false
}

resource "aws_route53_record" "agent1" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "agent1.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = 3600
  records = [aws_instance.jenkins_agent_1.public_ip]
}

output "jenkins_agent_1_public_ip" {
  value = aws_instance.jenkins_agent_1.public_ip
}