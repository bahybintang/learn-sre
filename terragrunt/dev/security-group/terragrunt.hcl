locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
}

terraform {
  source = "../../modules/security-group"
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  environment_tags = local.environment_vars.locals.tags
  security_groups = [
    {
      name = "dev-default-sg"
      vpc_id = dependency.vpc.outputs.vpc_id
      ingress_with_cidr_blocks = [
        { from_port = 22, to_port = 22, protocol = "tcp", description = "SSH from my IP", cidr_blocks = "${local.environment_vars.locals.my_ip}/32" },
        { from_port = 22, to_port = 22, protocol = "tcp", description = "SSH from public and private subnet", cidr_blocks = dependency.vpc.outputs.cidr_block },
        { from_port = 80, to_port = 80, protocol = "tcp", description = "HTTP open", cidr_blocks = "0.0.0.0/0" },
      ]
      egress_with_cidr_blocks = [
        { from_port = -1, to_port = -1, protocol = "-1", description = "Allow all egress", cidr_blocks = "0.0.0.0/0" },
      ]
    },
    {
      name = "dev-elb-sg"
      vpc_id = dependency.vpc.outputs.vpc_id
      ingress_with_cidr_blocks = [
        { from_port = 80, to_port = 80, protocol = "tcp", description = "HTTP open", cidr_blocks = "0.0.0.0/0" },
        { from_port = 443, to_port = 443, protocol = "tcp", description = "HTTPS open", cidr_blocks = "0.0.0.0/0" },
      ]
      egress_with_cidr_blocks = [
        { from_port = -1, to_port = -1, protocol = "-1", description = "Allow all egress", cidr_blocks = "0.0.0.0/0" },
      ]
    },
  ]
}