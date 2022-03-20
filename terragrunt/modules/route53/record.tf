resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.public.zone_id
  name = var.record_name
  type = var.record_type
  alias {
    name                   = var.elb_dns_name
    zone_id                = var.elb_zone_id
    evaluate_target_health = true
  }
}