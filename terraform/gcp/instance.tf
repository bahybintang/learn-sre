resource "google_compute_instance" "build_server" {
  name         = "build-server"
  machine_type = "e2-micro"
  zone         = var.DEFAULT_ZONE
  tags         = ["build"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = resource.google_compute_network.skripsi_network.id
    access_config {
      nat_ip = resource.google_compute_address.build_address.address
    }
  }

  # provisioner "file" {
  #   source      = "../scripts/apt-get"
  #   destination = "/tmp/apt-get"
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo cp /tmp/apt-get /usr/local/sbin",
  #     "sudo chmod +x /usr/local/sbin/apt-get",
  #     "wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -",
  #     "sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
  #     "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",
  #     "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
  #     "sudo  /usr/local/sbin/apt-get update -qq",
  #     "sudo  /usr/local/sbin/apt-get install -y default-jre",
  #     "sudo  /usr/local/sbin/apt-get install -y jenkins",
  #     "sudo  /usr/local/sbin/apt-get install -y docker-ce docker-ce-cli containerd.io",
  #     "sudo usermod -aG docker jenkins",
  #     "wget https://github.com/digitalocean/doctl/releases/download/v1.66.0/doctl-1.66.0-linux-amd64.tar.gz",
  #     # "tar -xvzf doctl-1.66.0-linux-amd64.tar.gz",
  #     # "chmod +x doctl",
  #     # "mv doctl /usr/local/bin",
  #     "curl -LO \"https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl\"",
  #     "sudo chmod +x kubectl",
  #     "sudo mv kubectl /usr/local/bin",
  #     "su - jenkins -c \"docker login -u ${var.DOCKER_USERNAME} -p ${var.DOCKER_PASSWORD}\"",
  #     # "su - jenkins -c \"doctl auth init -t ${var.DO_TOKEN}\"",
  #     # "su - jenkins -c \"doctl kubernetes cluster kubeconfig save skripsi-cluster\"",
  #     "sudo systemctl restart jenkins",
  #   ]
  # }

  # connection {
  #   host        = self.network_interface.0.access_config.0.nat_ip
  #   user        = "admin"
  #   type        = "ssh"
  #   private_key = file("../id_rsa")
  #   timeout     = "2m"
  # }
}
