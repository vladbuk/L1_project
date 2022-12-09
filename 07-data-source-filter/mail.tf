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

output "ubuntu20_latest_name" {
    value = data.aws_ami.ubuntu20_latest.name
}

output "ubuntu20_latest_id" {
    value = data.aws_ami.ubuntu20_latest.id
}