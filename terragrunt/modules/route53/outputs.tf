output "arn" {
  value = aws_route53_zone.public.arn
}

output "zone_id" {
  value = aws_route53_zone.public.zone_id
}

output "name_servers" {
  value = aws_route53_zone.public.name_servers
}