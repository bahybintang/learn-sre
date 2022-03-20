module "acm" {
  source  = "terraform-aws-modules/acm/aws"

  domain_name  = var.domain_name
  zone_id      = var.zone_id

  subject_alternative_names = var.subject_alternative_names
  create_route53_records = true
  wait_for_validation = true

  tags = merge({
    Terraform = "true"
  }, var.environment_tags)
}