module "sg" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "~> 3.4"
  name        = format("rmm-%s-%s-monitoringlb-sg", var.tags["Environment"], var.tags["Territory"])
  description = "Security group for RMM Monitoring LBs"
  vpc_id      = var.vpc_id
  tags        = var.tags

  use_name_prefix = true

  ingress_with_cidr_blocks = [
    {
      rule        = "https-443-tcp"
      cidr_blocks = join(",", flatten(var.cidr_blocks))
    },
    {
      rule        = "all-icmp"
      cidr_blocks = join(",", flatten(var.cidr_blocks))
    },
  ]

  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}
