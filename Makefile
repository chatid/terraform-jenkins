# Makefile to drive Jenkins deployment via terraform.
#
# Before you run this Makefile, you should load a certificate file (*.pem)
# into your ssh-agent appropriate to the environment you intend to deploy to.
#

# ####################################################
#

.PHONY: all plan apply destroy pull push configure

all :	plan

plan apply : 	main.tf variables.tf output.tf
	terraform $@

destroy :	terraform.tfstate
	terraform $@ -force

pull push :
	terraform remote $@


configure:
	terraform remote config -backend=s3 -backend-config="bucket=waqas-test" -backend-config="key=terraform/prosody" -backend-config="region=us-east-1"
