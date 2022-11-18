output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.t2micro_jenkins.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.t2micro_jenkins.public_ip
}