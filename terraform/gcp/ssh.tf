resource "google_compute_project_metadata_item" "default" {
  key   = "ssh-keys"
  value = "${var.SSH_USER}:${file("../id_rsa.pub")}}"
}
