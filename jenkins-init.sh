#!/bin/bash
# jenkins-init.sh: install, configure, and start the Jenkins server

#access_key=$1
#secret_key=$2
#s3_bucket=$3
#jenkins_name=$4

JENKINS_HOME=/var/lib/jenkins

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install -y jenkins

