module "bastion-host-sg" {
  source      = "../../modules/security_groups/bastion-host-sg"
  vpc_id      = module.vpc.vpc_id
  tags        = local.standard_tags
  openvpn_sg_id = module.openvpn-host-sg.id
  ssh_cidr_blocks = [
    local.ssh_cidr_blocks
  ]
}

module "openvpn-host-sg" {
  source      = "../../modules/security_groups/openvpn-host-sg"
  vpc_id      = module.vpc.vpc_id
  tags        = local.standard_tags
  ssh_cidr_blocks = [
    local.ssh_cidr_blocks
  ]
}

module "docker-host-sg" {
  source             = "../../modules/security_groups/docker-host-sg"
  vpc_id             = module.vpc.vpc_id
  bastion_host_sg_id = module.bastion-host-sg.id
  tags               = local.standard_tags
  docker_alb_sg_id   = module.docker-alb-sg.id
}

module "docker-alb-sg" {
  source              = "../../modules/security_groups/docker-alb-sg"
  vpc_id              = module.vpc.vpc_id
  tags                = local.standard_tags
}

module "monitoring-host-sg" {
  source             = "../../modules/security_groups/monitoring-host-sg"
  vpc_id             = module.vpc.vpc_id
  bastion_host_sg_id = module.bastion-host-sg.id
  cidr_blocks        = [
    local.ssh_cidr_blocks,
  ]
  tags                        = local.standard_tags
  vpc_cidr                    = var.vpc_cidr
}
