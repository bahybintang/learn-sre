module "ec2_instance" {
  count = length(var.instances)
  source  = "terraform-aws-modules/ec2-instance/aws"

  name                   = var.instances[count.index].name
  ami                    = var.instances[count.index].ami
  instance_type          = var.instances[count.index].instance_type
  key_name               = var.instances[count.index].key_name
  vpc_security_group_ids = var.instances[count.index].vpc_security_group_ids
  subnet_id              = var.instances[count.index].subnet_id
  user_data              = var.instances[count.index].user_data
  monitoring             = true

  tags = merge({
    Terraform = "true"
  }, var.environment_tags)
}