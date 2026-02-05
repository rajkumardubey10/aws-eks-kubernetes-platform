#!/bin/bash
set -e

LOG_FILE="/var/log/user-data.log"
exec > >(tee -a $LOG_FILE) 2>&1

echo "===== Starting DevOps Bootstrap ====="

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
# kubectl
# ----------------------------------
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# ----------------------------------
# eksctl
# ----------------------------------
curl -sL https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz \
| tar xz -C /tmp
mv /tmp/eksctl /usr/local/bin

# ----------------------------------
# Trivy
# ----------------------------------
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor \
  -o /usr/share/keyrings/trivy.gpg

echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] \
https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" \
> /etc/apt/sources.list.d/trivy.list

apt-get update -y
apt-get install -y trivy

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
# SonarQube (Optional)
# ----------------------------------
docker run -d \
  --name sonarqube \
  -p 9000:9000 \
  sonarqube:lts-community || true

# ----------------------------------
# Save Versions
# ----------------------------------
cat <<EOF > /home/ubuntu/tools.txt
Terraform: $(terraform version | head -1)
AWS: $(aws --version)
Kubectl: $(kubectl version --client --short)
Eksctl: $(eksctl version)
Docker: $(docker --version)
Trivy: $(trivy --version)
Jenkins: $(jenkins --version)
EOF

chown ubuntu:ubuntu /home/ubuntu/tools.txt

echo "===== Bootstrap Completed ====="
