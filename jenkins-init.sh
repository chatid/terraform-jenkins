#!/bin/bash
# jenkins-init.sh: install, configure, and start the Jenkins server

JENKINS_HOME=/var/lib/jenkins

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo $SHELL -c "yes '' | apt-get upgrade -y"
sudo apt-get install -y jenkins

