resource "digitalocean_ssh_key" "main_key" {
  name       = "Terraform Example"
  public_key = file("../id_rsa.pub")
}
