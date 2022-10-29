provider "aws" {}

resource "aws_instance" "t2micro_ubuntu22" {
    count = 1
    ami = "ami-0caef02b518350c8b"
    instance_type = "t2.micro"
    tags {
        Name = "t2micro_ubuntu22"
        Env = "test"
    }
}