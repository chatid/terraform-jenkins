# output.tf: emit selected AWS computed values
output "mode" {
  value = "[ ${var.mode} ]"
}

output "jenkins_public_dns" {
  value = "[ ${aws_instance.jenkins.public_dns} ]"
}

output "security_group" {
  value = "[ ${aws_security_group.sg_jenkins.name} ]"
}

