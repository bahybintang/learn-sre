resource "google_compute_instance" "build_server" {
  name         = "build-server"
  machine_type = "e2-micro"
  zone         = var.DEFAULT_ZONE
  tags         = ["build"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = resource.google_compute_network.skripsi_network.id
    access_config {
      nat_ip = resource.google_compute_address.build_address.address
    }
  }

  metadata = {
    user-data = data.template_cloudinit_config.build-config.rendered
  }
}
