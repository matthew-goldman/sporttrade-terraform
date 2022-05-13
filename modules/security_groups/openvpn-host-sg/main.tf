module "sg" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "~> 4.9"
  name        = format("%s-%s-openvpn-sg", var.tags["Environment"], var.tags["Territory"])
  description = "Security group for OpenVPN hosts"
  vpc_id      = var.vpc_id
  tags        = var.tags

  use_name_prefix = true

  ingress_with_cidr_blocks = [
    {
      rule        = "openvpn-udp"
      cidr_blocks = "0.0.0.0/0"
    },{
      rule        = "openvpn-tcp"
      cidr_blocks = "0.0.0.0/0"
    },{
      rule        = "openvpn-https-tcp"
      cidr_blocks = "0.0.0.0/0"
    },{
      rule        = "ssh-tcp"
      cidr_blocks = join(",", flatten(var.ssh_cidr_blocks))
    }
  ]

  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}
