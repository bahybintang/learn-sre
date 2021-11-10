resource "google_compute_project_metadata" "main_key" {
  metadata = {
    ssh-keys = "${var.SSH_USER}:${file("../id_rsa.pub")}}"
  }
}
