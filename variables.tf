# variables.tf: Configuration values for Jenkins Deployment via Terraform

variable "mode" {
  description = "The mode to deploy in ('dev','prod')."
  default = "dev"
#  default = "prod"
}

variable "access_keys" {
  description = "Table of AWS Access keys by environment"
  type = "map"
  default = {
    dev  = "AKIAJPKUYO4NKN4ZUFUQ"
    prod = "TODO"
  }
}

variable "secret_keys" {
  description = "Table of AWS Secret keys by environment"
  type = "map"
  default = {
    dev  = "1Qs51RLUb8p/i/MyC784pyqqz7KRREEDVr80Ag07"
    prod = "TODO"
  }
}

variable "region" {
  description = "The AWS region to create resources in."
  default = "us-east-1"
}

variable "availability_zone" {
  description = "The AWS availability zone"
  default = "us-east-1b"
}

variable "jenkins_name" {
  description = "The name of the Jenkins server."
  default = "jenkins"
}

variable "amis" {
  description = "Map region to AMI name to use in that region."
  type = "map"
  default = {
    us-east-1      = "ami-40d28157"
    us-west-1      = "ami-40d28157"
    us-west-2      = "ami-40d28157"
    eu-west-1      = "ami-40d28157"
    eu-central-1   = "ami-40d28157"
    ap-northeast-1 = "ami-40d28157"
    ap-southeast-1 = "ami-40d28157"
    ap-southeast-2 = "ami-40d28157"
  }
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "SSH key name in your AWS account for AWS instances."
  default = "jenkins"
}

/*
variable "s3_bucket" {
  description = "S3 bucket where remote state and Jenkins data will be stored."
  default = "chatid_${jenkins_name}"
}
*/
