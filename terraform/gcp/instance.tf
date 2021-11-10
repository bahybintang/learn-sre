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
      "bash /tmp/build-init.sh"
    ]
  }

  connection {
    host        = self.network_interface.0.access_config.0.nat_ip
    user        = "admin"
    type        = "ssh"
    private_key = file("../id_rsa")
    timeout     = "2m"
  }
}
