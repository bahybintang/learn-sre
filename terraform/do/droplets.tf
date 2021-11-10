resource "digitalocean_droplet" "build_server" {
  image    = "ubuntu-18-04-x64"
  name     = "build-server"
  region   = var.REGION
  size     = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.main_key.fingerprint]
  vpc_uuid = digitalocean_vpc.skripsi.id
  tags     = ["build-server"]

  provisioner "file" {
    source      = "../scripts/apt-get"
    destination = "/tmp/apt-get"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cp /tmp/apt-get /usr/local/sbin",
      "sudo chmod +x /usr/local/sbin/apt-get",
      "wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -",
      "sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",
      "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "sudo apt-get update -qq",
      "sudo apt-get install -y default-jre",
      "sudo apt-get install -y jenkins",
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io",
      "sudo usermod -aG docker jenkins",
      "wget https://github.com/digitalocean/doctl/releases/download/v1.66.0/doctl-1.66.0-linux-amd64.tar.gz",
      "tar -xvzf doctl-1.66.0-linux-amd64.tar.gz",
      "sudo chmod +x doctl",
      "sudo mv doctl /usr/local/bin",
      "curl -LO \"https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl\"",
      "sudo chmod +x kubectl",
      "sudo mv kubectl /usr/local/bin",
      "su - jenkins -c \"docker login -u ${var.DOCKER_USERNAME} -p ${var.DOCKER_PASSWORD}\"",
      "su - jenkins -c \"doctl auth init -t ${var.DO_TOKEN}\"",
      "su - jenkins -c \"doctl kubernetes cluster kubeconfig save skripsi-cluster\"",
      "sudo systemctl restart jenkins",
    ]
  }

  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file("../id_rsa")
    timeout     = "2m"
  }
}
