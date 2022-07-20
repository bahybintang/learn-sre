terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.DO_TOKEN
}

resource "digitalocean_vpc" "default" {
  name     = "keepalived-vpc"
  region   = var.REGION
  ip_range = "10.10.10.0/24"
}

resource "digitalocean_ssh_key" "default" {
  name       = "keepalived-key"
  public_key = file("/home/bintang.bahy@accelbyte.net/.ssh/id_ed25519.pub")
}

data "digitalocean_image" "ubuntu_image" {
  slug = "ubuntu-20-04-x64"
}

resource "digitalocean_droplet" "instance" {
  count    = var.DROPLETS_COUNT
  name     = "keepalived-${count.index}"
  image    = data.digitalocean_image.ubuntu_image.slug
  region   = var.REGION
  size     = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]
  vpc_uuid = digitalocean_vpc.default.id
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get install keepalived -y"
    ]
  }
  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file("/home/bintang.bahy@accelbyte.net/.ssh/id_ed25519")
    timeout     = "2m"
  }
}
