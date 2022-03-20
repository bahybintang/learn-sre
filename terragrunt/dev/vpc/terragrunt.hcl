locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
}

terraform {
  source = "../../modules/vpc"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  azs              = ["us-west-2a", "us-west-2b"]
  cidr_block       = "10.0.0.0/16"
  vpc_name         = "dev-vpc"
  private_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets   = ["10.0.3.0/24", "10.0.4.0/24"]
  environment_tags = local.environment_vars.locals.tags
}