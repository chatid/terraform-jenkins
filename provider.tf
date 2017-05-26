# provider.tf: Jenkins deployment via Terraform
#   dependancy: variables.tf for variable definitions

# Deploy on AWS EC2
provider "aws" {
  access_key	= "${lookup(var.access_keys, var.mode)}"
  secret_key	= "${lookup(var.secret_keys, var.mode)}"
  region     	= "${var.region}"
}

