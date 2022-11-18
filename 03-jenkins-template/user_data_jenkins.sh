#!/bin/bash
sudo apt update && \
sudo apt install -y openjdk-11-jre && \
java -version

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install -y jenkins mc

sudo apt update && \
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && \
sudo apt update && \
apt-cache policy docker-ce && \
sleep 5 && \
sudo apt install -y docker-ce && \
sudo systemctl status docker

sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu

sudo docker run -d --rm --name=agent1 -p 2222:22 -e "JENKINS_AGENT_SSH_PUBKEY=ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDSENt/Q25Mx78htFJFuIZC1geaAzXd/puOealYFRfbelojVJkDtdQUwW+650DzWFKuXzvOPtO24hYmkVaLqQeDJIsjKgJD0whCLLT8gWvnEE6FRCVprx7MZzMbTG1c7en+RAoJ/plN1sLtRz96BtM3rztDsT+GpN1BNX8Y0nKZMcekYfcrOxNRPHQ0KnuU3eXi/Ly//fTziin/Bshxo46X7w5EVBYwtcDo6CCMRTl8TMl3x31xFVbzkml3/919YNoUZCPE3Uc0jOKmeDYM3m9RUN4CumiUPGJ28x6vP7JKpBZuLSQfEGWFufp0zSDQAlOSAL7X5Piv6CMEkhNr245q6Ml1Xr/gdGP072tBZLz7OhMkZeyoBgAvXf6pYCSu4rbGuRb8xto2MT+mKxthOpxgONSg3kjOGCFqpMnFTIyrB4hfpPw9JQuyRSZyT1jPcZR9cl00YmgZXcBDrXna/RgWBntPASg7kLvqbw+q9wZZyL095ezsiFSd+HYPNtD8Jm0= ut@ubuntu-desktop" jenkins/ssh-agent:latest

#VARS1="HOME=|USER=|MAIL=|LC_ALL=|LS_COLORS=|LANG="
#VARS2="HOSTNAME=|PWD=|TERM=|SHLVL=|LANGUAGE=|_="
#VARS="${VARS1}|${VARS2}"
#sudo docker exec agent1 sh -c "env | egrep -v '^(${VARS})' >> /etc/environment"

