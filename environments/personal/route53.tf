module "split-horizon" {
  source           = "../../modules/aws-route53-split-horizon"
  hosted_zone_name = var.domain_name
  vpc_id           = module.vpc.vpc_id
  vpc_aws_region   = var.aws_region
  tags             = local.standard_tags
}

module "root-r53-ns" {
  source                 = "../../modules/aws-route53-ns-record"
  no_count               = true
  record_type            = "NS"
  record_name            = var.domain_name
  record_count           = var.add_root_dns ? 1 : 0
  records                = module.split-horizon.public_hosted_zone_ns
  hosted_zone_id         = var.root_route53_zone
}

module "openvpn-dns-records" {
  source                 = "../../modules/aws-route53-split-horizon-records"
  record_count           = var.openvpn_count
  record_name            = var.openvpn_name
  private_records        = module.ec2-instance-openvpn.private_ip
  public_records         = module.ec2-instance-openvpn.public_ip
  private_hosted_zone_id = module.split-horizon.private_hosted_zone_id
  public_hosted_zone_id  = module.split-horizon.public_hosted_zone_id
}

module "openvpn-simple-dns-records" {
  source                 = "../../modules/aws-route53-simple-records"
  record_count           = var.openvpn_count
  no_count               = true
  record_name            = "vpn"
  records                = module.ec2-instance-openvpn.public_ip
  hosted_zone_id         = module.split-horizon.public_hosted_zone_id
}

## Docker ALB R53
module "docker-alb-dns-records" {
  source                 = "../../modules/aws-route53-split-horizon-alias-records"
  record_count           = var.docker_host_count != 1 && var.docker_host_alb_create == true ? 1 : var.docker_host_count
  record_name            = "webapp"
  private_alias_target   = format("dualstack.%s", module.docker_host_alb.aws_lb_dns)
  private_alias_zone     = module.docker_host_alb.aws_lb_zone_id
  public_alias_target    = format("dualstack.%s", module.docker_host_alb.aws_lb_dns)
  public_alias_zone      = module.docker_host_alb.aws_lb_zone_id  
  public_hosted_zone_id  = module.split-horizon.public_hosted_zone_id
  private_hosted_zone_id = module.split-horizon.private_hosted_zone_id
  record_type            = "A"
}

module "docker-host-dns-records" {
  source                 = "../../modules/aws-route53-simple-records"
  record_count           = var.docker_host_count
  record_name            = var.docker_host_name
  records                = module.ec2-instance-docker-host.private_ip
  hosted_zone_id         = module.split-horizon.private_hosted_zone_id
}

module "monitoring-host-dns-records" {
  source                 = "../../modules/aws-route53-simple-records"
  record_count           = var.monitoring_host_count
  record_name            = var.monitoring_host_name
  records                = module.ec2-instance-monitoring-host.private_ip
  hosted_zone_id         = module.split-horizon.private_hosted_zone_id
}

module "bastion-dns-records" {
  source                 = "../../modules/aws-route53-split-horizon-records"
  record_count           = var.bastion_count
  record_name            = var.bastion_name
  private_records        = module.ec2-instance-bastion.private_ip
  public_records         = module.ec2-instance-bastion.public_ip
  private_hosted_zone_id = module.split-horizon.private_hosted_zone_id
  public_hosted_zone_id  = module.split-horizon.public_hosted_zone_id
}