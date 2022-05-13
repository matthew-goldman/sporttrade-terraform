data "aws_vpc" "vpc" {
  id = var.vpc_id
}

module "sg" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "~> 4.9"
  name        = format("%s-%s-monitoring-sg", var.tags["Environment"], var.tags["Territory"])
  description = "Security group for hosts so that they can be monitored within the VPC"
  vpc_id      = var.vpc_id
  tags        = var.tags

  use_name_prefix = true

  ingress_with_source_security_group_id = [
    {
      rule                     = "ssh-tcp"
      source_security_group_id = var.monitoring_host_sg_id
    },
    # {
    #   from_port                = 4949
    #   to_port                  = 4949
    #   protocol                 = "tcp"
    #   source_security_group_id = var.monitoring_host_sg_id
    # },
    # {
    #   from_port                = 5666
    #   to_port                  = 5666
    #   protocol                 = "tcp"
    #   source_security_group_id = var.monitoring_host_sg_id
    # }
  ]

  ingress_with_cidr_blocks = [
    {
      rule        = "all-icmp"
      cidr_blocks = data.aws_vpc.vpc.cidr_block
    }
  ]
}
