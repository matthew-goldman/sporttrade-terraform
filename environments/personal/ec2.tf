resource "aws_key_pair" "default" {
  key_name   = "ssh-key-${var.territory}"
  public_key = var.default_public_key
}

module "ec2-instance-bastion" {
  source                  = "../../modules/aws-ec2-instance"
  name                    = var.bastion_name
  ami                     = (var.bastion_ami == "" ? data.aws_ami.centos-8.id : var.bastion_ami)
  instance_type           = var.bastion_instancetype
  instance_count          = var.bastion_count
  key_name                = aws_key_pair.default.key_name
  subnet_id               = module.vpc.public_subnets[0]
  root_block_device       = var.bastion_root_volume
  associate_public_eip    = true
  tags                    = local.standard_tags
  dns_domain              = var.domain_name
  disable_api_termination = var.bastion_disable_api_termination
  security_groups         = [
    module.bastion-host-sg.id
  ]
}

module "ec2-instance-docker-host" {
  source                  = "../../modules/aws-ec2-instance"
  name                    = var.docker_host_name
  ami                     = data.aws_ami.centos-8.id
  instance_type           = var.docker_host_instancetype
  instance_count          = var.docker_host_count
  key_name                = aws_key_pair.default.key_name
  subnet_id               = module.vpc.private_subnets[0]
  root_block_device       = var.docker_host_root_volume
  tags                    = local.standard_tags
  dns_domain              = var.domain_name
  disable_api_termination = var.docker_host_disable_api_termination
  security_groups         = [
    module.docker-host-sg.id
  ]
}

module "ec2-instance-openvpn" {
  source                  = "../../modules/aws-ec2-instance"
  name                    = var.openvpn_name
  ami                     = (var.openvpn_ami == "" ? data.aws_ami.centos-8.id : var.openvpn_ami)
  instance_type           = var.openvpn_instancetype
  instance_count          = var.openvpn_count
  key_name                = aws_key_pair.default.key_name
  subnet_id               = module.vpc.public_subnets[0]
  root_block_device       = var.openvpn_root_volume
  associate_public_eip    = true
  tags                    = local.standard_tags
  dns_domain              = var.domain_name
  disable_api_termination = var.openvpn_disable_api_termination
  security_groups         = [
    module.openvpn-host-sg.id
  ]
}

module "ec2-instance-monitoring-host" {
  source                  = "../../modules/aws-ec2-instance"
  name                    = var.monitoring_host_name
  ami                     = data.aws_ami.centos-8.id
  instance_type           = var.monitoring_host_instancetype
  instance_count          = var.monitoring_host_count
  key_name                = aws_key_pair.default.key_name
  subnet_id               = module.vpc.private_subnets[0]
  root_block_device       = var.monitoring_host_root_volume
  tags                    = local.standard_tags
  dns_domain              = var.domain_name
  disable_api_termination = var.monitoring_host_disable_api_termination
  security_groups         = [
    module.monitoring-host-sg.id
  ]
}