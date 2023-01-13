output "jenkins_instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.t2micro_jenkins.id
}

output "jenkins_instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.t2micro_jenkins.public_ip
}

/*
output "agent_instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.t2micro_jenkins_agent.id
}

output "agent_instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.t2micro_jenkins_agent.public_ip
}
*/