locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
}

terraform {
  source = "../../modules/acm"
}

dependency "route53" {
  config_path = "../route53"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  domain_name = local.environment_vars.locals.root_domain
  zone_id = dependency.route53.outputs.zone_id
  environment_tags = local.environment_vars.locals.tags
}