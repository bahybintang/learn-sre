module "security_group" {
  count = length(var.security_groups)
  source = "terraform-aws-modules/security-group/aws"

  name        = var.security_groups[count.index].name
  vpc_id      = var.security_groups[count.index].vpc_id
  ingress_with_cidr_blocks = var.security_groups[count.index].ingress_with_cidr_blocks
  egress_with_cidr_blocks = var.security_groups[count.index].egress_with_cidr_blocks

  tags = merge({
    "Terraform" = "true"
  }, var.environment_tags)
}