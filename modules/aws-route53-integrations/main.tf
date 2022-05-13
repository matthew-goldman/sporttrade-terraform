resource "aws_route53_record" "record" {
  count   = var.record_count
  zone_id = var.hosted_zone_id
  name    = var.record_name[count.index]
  type    = var.record_type

  alias {
    name  = var.record
    zone_id = var.target_zone_id
    evaluate_target_health = true
  }
}
