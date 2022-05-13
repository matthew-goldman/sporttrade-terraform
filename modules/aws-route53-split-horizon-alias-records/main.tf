resource "aws_route53_record" "public_record" {
  count   = var.record_count

  zone_id = var.public_hosted_zone_id
  name    = var.record_name
  type    = var.record_type

  alias {
    name    = var.public_alias_target
    zone_id = var.public_alias_zone
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "private_record" {
  count   = var.record_count
  
  zone_id = var.private_hosted_zone_id
  name    = var.record_name
  type    = var.record_type

  alias {
    name    = var.private_alias_target
    zone_id = var.private_alias_zone
    evaluate_target_health = true
  }
}
