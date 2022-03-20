output "discovered_availability_zones" {
  value = module.vpc.azs
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets_ids" {
  value = module.vpc.private_subnets
}

output "private_subnets_cidr_blocks" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "public_subnets_ids" {
  value = module.vpc.public_subnets
}

output "public_subnets_cidr_blocks" {
  value = module.vpc.public_subnets_cidr_blocks
}

output "nat_ids" {
  value = module.vpc.natgw_ids
}

output "cidr_block" {
  value = module.vpc.vpc_cidr_block
}
