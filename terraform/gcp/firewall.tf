resource "google_compute_firewall" "skripsi_firewall" {
  name    = "skripsi-firewall"
  network = resource.google_compute_network.skripsi_network.id

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "22"]
  }

  source_ranges = ["0.0.0.0/0"]
}
