resource  "aws_route53_zone" "public" {
  name = var.hosted_zone_name
}

resource  "aws_route53_zone" "private" {
  name = var.hosted_zone_name
  vpc {
    vpc_id     = var.vpc_id
    vpc_region = var.vpc_aws_region
  }
  lifecycle {     # Prevents Route53 from dis-associating from a private zone
    ignore_changes = [
      vpc
    ]
  }
}
