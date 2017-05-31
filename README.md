# Terraformed Jenkins

Deploy Jenkins 2.0 in an AWS EC2 instance using [Terraform](https://www.terraform.io/).

## Usage

The AWS access credentials are stored in the `variables.tf` file, in the "access_keys" and "secret_keys" maps. 
Multiple versions are stored, indexed by AWS region.

Before you run the Makefile, you should add the appropriate certificate files to the calling 
environment's ssh-agent to authenticate with AWS:
```
$ ls -alp ~/.ssh/*.pem
-r-------- 1 user user 1696 May 24 10:05 /home/user/.ssh/dev-deploy.pem
$ ssh-add /home/user/.ssh/dev-deploy.pem
Identity added: /home/user/.ssh/dev-deploy.pem (/home/user/.ssh/dev-deploy.pem)
$ ssh-add -l 
2048 SHA256:oLuseNH/JLCwlX6Y5SIJZxmtGvFy0RKdmfuEGit2bw4 /home/user/.ssh/dev-deploy.pem (RSA)
1024 SHA256:VxFOC/5URCdbmLoxRC7v+9TJdsxHk/R/Hu20j4sGF9c user@host (DSA)
2048 SHA256:yaw2ehDXhLaMPmGE1TIB67seJdn+qeFkjxCTxp3CMYE user@host (RSA)
$ 
```

### Run 'terraform plan'

    make

### Run 'terraform apply'

    make apply


### Run 'terraform destroy'

    make destroy

Upon completion, terraform will output the DNS name of Jenkins, e.g.:
```
jenkins_public_dns = [ ec2-54-235-229-108.compute-1.amazonaws.com ]
```
You can then reach Jenkins via your browser at `http://ec2-54-235-229-108.compute-1.amazonaws.com:8080`.

