#!/usr/bin/env bash

sudo cp /tmp/apt-get /usr/local/sbin
sudo chmod +x /usr/local/sbin/apt-get
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo /usr/local/sbin/apt-get update -qq
sudo /usr/local/sbin/apt-get install -y default-jre
sudo /usr/local/sbin/apt-get install -y jenkins
sudo /usr/local/sbin/apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker jenkins
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin
sudo systemctl start jenkins
