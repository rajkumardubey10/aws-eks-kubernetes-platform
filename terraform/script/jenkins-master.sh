#!/bin/bash
set -e

LOG_FILE="/var/log/jenkins-master-bootstrap.log"
exec > >(tee -a $LOG_FILE) 2>&1

echo "===== Starting Jenkins Master Bootstrap ====="

export DEBIAN_FRONTEND=noninteractive

# ----------------------------------
# Update System
# ----------------------------------
apt-get update -y
apt-get upgrade -y

# ----------------------------------
# Base Packages
# ----------------------------------
apt-get install -y \
  curl \
  wget \
  unzip \
  gnupg \
  software-properties-common \
  ca-certificates \
  lsb-release \
  apt-transport-https

# ----------------------------------
# Java (For Jenkins)
# ----------------------------------
apt-get install -y openjdk-17-jre

# ----------------------------------
# Docker
# ----------------------------------
curl -fsSL https://get.docker.com | bash

systemctl enable docker
systemctl start docker

# Add ubuntu user to docker group
usermod -aG docker ubuntu

# ----------------------------------
# Terraform
# ----------------------------------
curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor \
  -o /usr/share/keyrings/hashicorp.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
> /etc/apt/sources.list.d/hashicorp.list

apt-get update -y
apt-get install -y terraform

# ----------------------------------
# AWS CLI v2
# ----------------------------------
cd /tmp
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip
unzip awscliv2.zip
./aws/install

# ----------------------------------
# Jenkins
# ----------------------------------
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | gpg --dearmor \
  -o /usr/share/keyrings/jenkins.gpg

echo "deb [signed-by=/usr/share/keyrings/jenkins.gpg] \
https://pkg.jenkins.io/debian-stable binary/" \
> /etc/apt/sources.list.d/jenkins.list

apt-get update -y
apt-get install -y jenkins

systemctl enable jenkins
systemctl start jenkins

# ----------------------------------
# Save Versions
# ----------------------------------
cat <<EOF > /home/ubuntu/jenkins-master-tools.txt
Java: $(java -version 2>&1 | head -1)
Docker: $(docker --version)
Terraform: $(terraform version | head -1)
AWS: $(aws --version)
Jenkins: $(jenkins --version)
EOF

chown ubuntu:ubuntu /home/ubuntu/jenkins-master-tools.txt

echo "===== Jenkins Master Setup Completed ====="
