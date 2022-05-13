module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 2.5"

  create_certificate = var.create_certificate
  domain_name        = var.domain_name
  zone_id            = var.zone_id
  validation_method  = var.validation_method
  subject_alternative_names = var.create_wildcard ?  ["*.${var.domain_name}"] : var.subject_alternative_names
  validate_certificate = var.validate_certificate
  tags = var.tags
}
