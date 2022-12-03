provider "aws" {
  region = "eu-central-1"
  shared_credentials_files = ["$HOME/.aws/credentials"]
  profile = "default"
}

data "aws_caller_identity" "current_id" {}
data "aws_availability_zones" "working_zones" {}

output "aws_caller_identity" {
  value = data.aws_caller_identity.current_id.id
}

output "aws_availability_zones" {
  value = data.aws_availability_zones.working_zones.names
}