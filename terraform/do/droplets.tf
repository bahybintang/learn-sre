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
      "cp /tmp/apt-get /usr/local/sbin",
      "chmod +x /usr/local/sbin/apt-get",
      "wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -",
      "sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
      "sudo apt update -qq",
      "sudo apt install -y default-jre",
      "sudo apt install -y jenkins",
      "sudo systemctl start jenkins",
      "sudo ufw allow 8080",
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
