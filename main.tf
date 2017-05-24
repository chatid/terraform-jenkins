# main.tf: Jenkins deployment via Terraform
#   dependancy: variables.tf for variable definitions
#   dependancy: appropriate identity cert (${var.key_name}.pem) loaded in ssh-agent

# Deploy on AWS EC2
provider "aws" {
  access_key	= "${lookup(var.access_keys, var.mode)}"
  secret_key	= "${lookup(var.secret_keys, var.mode)}"
  region     	= "${var.region}"
}

/* TODO: create S3 bucket and store remote state
resource "terraform_remote_state" "tfstate" {
  backend = "s3"

  config {
    bucket	= "mycompany-terraform"
    key		= "terraform/terraform.tfstate"
    region	= "${var.region}"
  }
}
*/

# EC2 security group specific to Jenkins master
resource "aws_security_group" "sg_jenkins" {
  name = "sg_jenkins"
  description = "Firewall definition for Jenkins master."

  # SSH
  ingress {
    from_port	= 22
    to_port	= 22
    protocol	= "tcp"
    cidr_blocks	= ["0.0.0.0/0"]
  }

  # HTTP
  ingress {
    from_port	= 8080
    to_port	= 8080
    protocol	= "tcp"
    cidr_blocks	= ["0.0.0.0/0"]
  }

  # Jenkins JNLP port
  ingress {
    from_port 	= 50000
    to_port 	= 50000
    protocol 	= "tcp"
    cidr_blocks	= ["0.0.0.0/0"]
  }

  # All outbound traffic allowed
  egress {
    from_port 	= 0
    to_port 	= 0
    protocol 	= "-1"
    cidr_blocks	= ["0.0.0.0/0"]
  }
}

# EC2 instance definition
resource "aws_instance" "jenkins" {
  instance_type		= "${var.instance_type}"
  security_groups 	= ["${aws_security_group.sg_jenkins.name}"]
  ami			= "${lookup(var.amis, var.region)}"
  key_name		= "${var.key_name}"
  associate_public_ip_address = "false"

  tags {
    "Name" = "${var.jenkins_name}"
  }

  # Obtain, install, and configure Jenkins service
  provisioner "remote-exec" {
    connection {
      type	= "ssh"
      user	= "ubuntu"
      agent	= "true"
    }
    script	= "jenkins-init.sh"
  }

  # Retrieve the generated initial admin password
  provisioner "local-exec" {
    command 	= "ssh ubuntu@${aws_instance.jenkins.public_ip} sudo cat /var/lib/jenkins/secrets/initialAdminPassword >/tmp/initialAdminPassword"
  }

/* TODO: add post-configuration script
  # Add backup task to crontab
  provisioner "file" {
    connection {
      user 	= "ubuntu"
      host 	= "${aws_instance.jenkins.public_ip}"
      timeout 	= "1m"
      key_file 	= "${var.key_name}.pem"
    }
    source 	= "templates/cron.sh"
    destination	= "/home/ubuntu/tf/cron.sh"
  }
*/

/* TODO: invoke post-installation configuration
  provisioner "remote-exec" {
    connection {
      user 	= "ubuntu"
      host 	= "${aws_instance.jenkins.private_ip}"
      timeout 	= "1m"
      agent	= "true"
    }
    inline = [
      "chmod +x /home/ec2-user/cron.sh",
      "/home/ec2-user/cron.sh ${var.access_key} ${var.secret_key} ${var.s3_bucket} ${var.jenkins_name}"
    ]
  }
*/
}

