output "instance_test_id" {
  description = "ID of the t2micro_ubuntu_test"
  value       = aws_instance.t2micro_ubuntu_test.id
}

output "instance_test_public_ip" {
  description = "Public IP address of the t2micro_ubuntu_test"
  value       = aws_instance.t2micro_ubuntu_test.public_ip
}
