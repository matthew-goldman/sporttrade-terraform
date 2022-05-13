resource "aws_route53_record" "public_record" {
  count   = var.record_count
  zone_id = var.public_hosted_zone_id
  name    = format("%s-%02d", var.record_name, count.index + 1)
  type    = var.record_type
  ttl     = var.record_ttl
  records = [element(var.public_records, count.index)]
}

resource "aws_route53_record" "private_record" {
  count   = var.record_count
  zone_id = var.private_hosted_zone_id
  name    = format("%s-%02d", var.record_name, count.index + 1)
  type    = var.record_type
  ttl     = var.record_ttl
  records = [element(var.private_records, count.index)]
}
