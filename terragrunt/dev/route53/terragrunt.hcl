locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
}

terraform {
  source = "../../modules/route53"
}

dependency "elb_http" {
  config_path = "../elb-http"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  environment_tags = local.environment_vars.locals.tags
  zone = local.environment_vars.locals.root_domain
  record_name = ""
  record_type = "A"
  elb_dns_name = dependency.elb_http.outputs.elb_dns_name
  elb_zone_id = dependency.elb_http.outputs.elb_zone_id
}