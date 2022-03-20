resource "tls_private_key" "key" {
  algorithm   = "RSA"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = var.key_name
  public_key = tls_private_key.key.public_key_openssh
  tags = merge({
    "Terraform" = "true"
  }, var.environment_tags)
}