resource "google_compute_network" "skripsi_network" {
  name = "skripsi-network"
}

resource "google_compute_address" "build_address" {
  name   = "ipv4-address"
  region = var.DEFAULT_REGION
}
