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

  provisioner "file" {
    source      = "../scripts/build-init.sh"
    destination = "/tmp/build-init.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "bash /tmp/build-init.sh",
      "wget https://github.com/digitalocean/doctl/releases/download/v1.66.0/doctl-1.66.0-linux-amd64.tar.gz",
      "tar -xvzf doctl-1.66.0-linux-amd64.tar.gz",
      "sudo chmod +x doctl",
      "sudo mv doctl /usr/local/bin",
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
