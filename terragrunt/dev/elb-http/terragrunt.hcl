locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
}

terraform {
  source = "../../modules/elb-http"
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "security_group" {
  config_path = "../security-group"
}

dependency "ec2" {
  config_path = "../ec2"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name = "dev-elb-http"
  subnets = [dependency.vpc.outputs.public_subnets_ids[0], dependency.vpc.outputs.private_subnets_ids[1]]
  security_groups = dependency.security_group.outputs.security_group_id
  internal = false
  number_of_instances = 2
  instances = dependency.ec2.outputs.instance_id
  environment_tags = local.environment_vars.locals.tags
}