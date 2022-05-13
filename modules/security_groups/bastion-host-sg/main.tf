module "sg" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "~> 4.9"
  name        = format("%s-%s-bastion-sg", var.tags["Environment"], var.tags["Territory"])
  description = "Security group for bastion hosts"
  vpc_id      = var.vpc_id
  tags        = var.tags

  use_name_prefix = true

  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = join(",", flatten(var.ssh_cidr_blocks))
    }
  ]

  ingress_with_source_security_group_id = [
    {
      rule                     = "ssh-tcp"
      source_security_group_id = var.openvpn_sg_id
    },
  ]
  

  # Fallback, allow home access
  # ingress_with_cidr_blocks = [
  #   {
  #     rule        = "ssh-tcp"
  #     cidr_blocks = "136.56.34.156/32"
  #   },
  # ]

  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}