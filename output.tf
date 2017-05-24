# output.tf: emit selected AWS computed values
output "mode" {
  value = "[ ${var.mode} ]"
}

output "security_group" {
  value = "[ ${aws_security_group.sg_jenkins.name} ]"
}

output "key_name" {
  value = "[ ${aws_instance.jenkins.key_name} ]"
}

output "jenkins_public_ip" {
  value = "[ ${aws_instance.jenkins.public_ip} ]"
}

output "jenkins_private_ip" {
  value = "[ ${aws_instance.jenkins.private_ip} ]"
}

