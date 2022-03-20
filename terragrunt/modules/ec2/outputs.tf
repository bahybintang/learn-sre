output "instance_arn" {
  value = module.ec2_instance[*].arn
}

output "instance_public_ip" {
  value = module.ec2_instance[*].public_ip
}

output "instance_public_dns" {
  value = module.ec2_instance[*].public_dns
}

output "instance_private_ip" {
  value = module.ec2_instance[*].private_ip
}

output "instance_id" {
  value = module.ec2_instance[*].id
}