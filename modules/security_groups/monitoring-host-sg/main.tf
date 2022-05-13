module "sg" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "~> 3.4"
  name        = format("rmm-%s-%s-monitoring-host-sg", var.tags["Environment"], var.tags["Territory"])
  description = "Security group for RMM monitoring hosts"
  vpc_id      = var.vpc_id
  tags        = var.tags

  use_name_prefix = true

  ingress_with_source_security_group_id = [
    {
      rule                     = "ssh-tcp"
      source_security_group_id = var.bastion_host_sg_id
    # },{
    #   rule                     = "http-80-tcp"
    #   source_security_group_id = var.monitoring_lb_sg_id
    #   description              = "Monitoring"
    },{
      from_port   = 9080
      to_port     = 9080
      protocol    = "tcp"
      source_security_group_id = var.bastion_host_sg_id
      description = "Allow Grafana traffic from Bastion"
    # },{
    #   from_port   = 9080
    #   to_port     = 9080
    #   protocol    = "tcp"
    #   source_security_group_id = var.monitoring_lb_sg_id
    #   description = "Allow Grafana traffic from MGMT ALB"
    }
  ]

  ingress_with_cidr_blocks = [
    {
      rule        = "all-icmp"
      cidr_blocks = var.vpc_cidr
    }
  ]

  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}
