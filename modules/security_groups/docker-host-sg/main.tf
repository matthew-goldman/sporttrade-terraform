module "sg" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "~> 4.9"
  name        = format("%s-%s-docker-engine-sg", var.tags["Environment"], var.tags["Territory"])
  description = "Security group for Docker Engine hosts"
  vpc_id      = var.vpc_id
  tags        = var.tags

  use_name_prefix = true

  ingress_with_source_security_group_id = [
    {
      rule                     = "ssh-tcp"
      source_security_group_id = var.bastion_host_sg_id
    },{
      rule                     = "http-80-tcp"
      source_security_group_id = var.docker_alb_sg_id
      description              = "Docker ALB"
    }
  ]

  

  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}
