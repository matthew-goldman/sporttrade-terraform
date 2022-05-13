resource "aws_route53_record" "public_record" {
  count   = var.record_count >= 1 && var.public_records != "" ? var.record_count : 0
  zone_id = var.public_hosted_zone_id
  name    = var.record_name
  type    = var.record_type
  ttl     = var.record_ttl
  records = [var.public_records]
}

resource "aws_route53_record" "private_record" {
  count   = var.record_count
  zone_id = var.private_hosted_zone_id
  name    = var.record_name
  type    = var.record_type
  ttl     = var.record_ttl
  records = [var.private_records]
}
