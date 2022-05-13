resource "aws_route53_record" "record" {
  count   = var.record_count
  zone_id = var.hosted_zone_id
  name    = var.no_count ? var.record_name : format("%s-%02d", var.record_name, count.index + 1)
  type    = var.record_type
  ttl     = var.record_ttl
  records = [element(var.records, count.index)]
}
