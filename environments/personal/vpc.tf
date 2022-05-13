module "vpc" {
  source     = "../../modules/aws-ec2-vpc"
  vpc_cidr   = var.vpc_cidr
  name       = "vpc-${local.project}-${var.territory}-${local.environment}-01"
  aws_region = var.aws_region
  tags       = local.standard_tags
}
