locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
}

terraform {
  source = "../../modules/key-pair"
}

inputs = {
  key_name = "main-key"
  environment_tags = local.environment_vars.locals.tags
}