module "acm" {
    source             = "../../modules/aws-acm"
    create_certificate = var.acm_create_certificate
    domain_name        = var.domain_name
    zone_id            = module.split-horizon.public_hosted_zone_id
    territory          = var.territory
    create_wildcard    = var.acm_create_wildcard
    validate_certificate = var.acm_validate_certificate
    tags               = local.standard_tags
}