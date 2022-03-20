locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  user_data = <<EOF
sudo yum update -y
sudo yum install -y httpd.x86_64
sudo systemctl start httpd.service
sudo systemctl enable httpd.service
EOF
}

terraform {
  source = "../../modules/ec2"
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "security_group" {
  config_path = "../security-group"
}

dependency "key_pair" {
  config_path = "../key-pair"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  environment_tags = local.environment_vars.locals.tags
  instances = [
    {
      name = "instance-public"
      ami = "ami-0eb324d928acca58a"
      instance_type = "t2.micro"
      key_name = dependency.key_pair.outputs.key_pair_key_name
      vpc_security_group_ids = dependency.security_group.outputs.security_group_id
      subnet_id = dependency.vpc.outputs.public_subnets_ids[0]
      user_data = local.user_data
    },
    {
      name = "instance-private"
      ami = "ami-0eb324d928acca58a"
      instance_type = "t2.micro"
      key_name = dependency.key_pair.outputs.key_pair_key_name
      vpc_security_group_ids = dependency.security_group.outputs.security_group_id
      subnet_id = dependency.vpc.outputs.private_subnets_ids[1]
      user_data = local.user_data
    },
  ]
}