output "private_key_pem" {
  value = resource.tls_private_key.key.private_key_pem
  sensitive = true
}

output "public_key_pem" {
  value = resource.tls_private_key.key.public_key_pem
}

output "public_key_openssh" {
  value = resource.tls_private_key.key.public_key_openssh
}

output "key_pair_key_pair_id" {
  value = module.key_pair.key_pair_key_pair_id
}

output "key_pair_key_name" {
  value = module.key_pair.key_pair_key_name
}