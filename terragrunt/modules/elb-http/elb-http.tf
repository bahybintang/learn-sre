module "elb_http" {
  source  = "terraform-aws-modules/elb/aws"

  name            = var.name
  subnets         = var.subnets
  security_groups = var.security_groups
  internal        = var.internal
  number_of_instances = var.number_of_instances
  instances = var.instances

  listener = [
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 80
      lb_protocol       = "HTTP"
    },
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 443
      lb_protocol       = "HTTPS"
      ssl_certificate_id = var.acm_certificate_arn
    },
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  tags = merge({
    Terraform = "true"
  }, var.environment_tags)
}