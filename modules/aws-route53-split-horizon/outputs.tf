output "private_hosted_zone_id" {
  description = "The id of the private hosted zone"
  value       = aws_route53_zone.private.zone_id
}

output "public_hosted_zone_id" {
  description = "The id of the public hosted zone"
  value       = aws_route53_zone.public.zone_id
}

output "public_hosted_zone_ns" {
  description = "NS Values of Public Zone"
  value       = aws_route53_zone.public.name_servers
}