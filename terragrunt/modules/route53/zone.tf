resource "aws_route53_zone" "public" {
  name = var.zone
  tags = merge({
    Terraform = "true"
  }, var.environment_tags)
}