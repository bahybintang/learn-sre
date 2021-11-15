#cloud-config

packages:
  - apt-transport-https
  - ca-certificates
  - curl
  - gnupg-agent
  - software-properties-common
  - gnupg2

# create the docker group
groups:
  - docker

# Install docker, jenkins, and kubectl
runcmd:
  # Add repository
  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  - sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  - curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null
  - echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
  - curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
  - echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list

  # Install
  - sudo apt-get update -y
  - sudo apt-get install -y docker-ce docker-ce-cli containerd.io jenkins kubectl
  - sudo systemctl start docker
  - sudo systemctl enable docker
  - sudo systemctl start jenkins
  - sudo systemctl enable jenkins

# Add default auto created user to docker group
system_info:
  default_user:
    groups: [docker]
  jenkins:
    groups: [docker]
