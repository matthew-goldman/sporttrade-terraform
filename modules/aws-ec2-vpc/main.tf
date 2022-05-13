data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

resource "aws_eip" "nat" {
  count = 3
  vpc = true
  tags = merge(
    var.tags,
    { Name = format("%s-%s-nat-eip-%02d", var.tags["Environment"], var.tags["Territory"], count.index + 1) }
  )
}

module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "~> 2.78"
  cidr            = var.vpc_cidr
  name            = format("%s-%s-vpc", var.tags["Environment"], var.tags["Territory"])
  azs             = [
    "${var.aws_region}a",
    "${var.aws_region}b",
    "${var.aws_region}c"
  ]
  private_subnets = [
    cidrsubnet(var.vpc_cidr,3,2),
    cidrsubnet(var.vpc_cidr,3,3),
    cidrsubnet(var.vpc_cidr,3,4)
  ]
  public_subnets = [
    cidrsubnet(var.vpc_cidr,4,0),
    cidrsubnet(var.vpc_cidr,4,1),
    cidrsubnet(var.vpc_cidr,4,2)
  ]
  database_subnets = [
    cidrsubnet(var.vpc_cidr,6,12),
    cidrsubnet(var.vpc_cidr,6,13),
    cidrsubnet(var.vpc_cidr,6,14)
  ]
  intra_subnets    = [
    cidrsubnet(var.vpc_cidr,4,10),
    cidrsubnet(var.vpc_cidr,4,11),
    cidrsubnet(var.vpc_cidr,4,12)
  ]
  enable_dns_hostnames             = true
  enable_nat_gateway               = true
  one_nat_gateway_per_az           = true
  reuse_nat_ips                    = true
  external_nat_ip_ids              = aws_eip.nat.*.id

  enable_s3_endpoint               = true

  enable_ec2_endpoint              = true
  ec2_endpoint_private_dns_enabled = true
  ec2_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  tags = var.tags
}
resource "aws_default_security_group" "default" {
  vpc_id = module.vpc.vpc_id

  tags = merge(
    var.tags,
    { Name = format("%s-%s-default-sg", var.tags["Environment"], var.tags["Territory"]) }
  )
}
